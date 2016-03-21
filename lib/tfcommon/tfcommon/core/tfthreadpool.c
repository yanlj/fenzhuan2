//
//  tfthreadpool.c
//  tfcommon0.5
//
//  Created by yin shen on 11/5/12.
//
//

#include <stdio.h>
#include <pthread.h>
#include <assert.h>
#include <sys/time.h>
#include "tfthreadpool.h"
#include <sched.h>

void *malloc(size_t);
void free(void *);
void *calloc(size_t, size_t);

void _tfthread_init(tfthread_t **thread);

#define printf(...)

tfthread_t *tfthreadpool_idle_thread(tfthreadpool_t *threadpool);


void push_queue(tftask_queue_t *queue,tftask_t *task){
    
    switch (queue->count) {
        case 0:
            queue->rear = task;
            queue->front = task;
            break;
            
        default:
            queue->rear->next = task;
            queue->rear = task;
            break;
    }
    
    queue->count++;
}

tftask_t* pull_queue(tftask_queue_t *queue){
    
    tftask_t *task = queue->front;
    
    switch (queue->count) {
        case 0:
            return NULL;
        case 1:
            queue->front = NULL;
            queue->rear = NULL;
            break;
        default:
            queue->front = queue->front->next;
            break;
    }
    
    queue->count--;
    return task;
}

void *tfthreadpool_task_run2(void *arg){
    tfthread_t *thread = (tfthread_t *)arg;
    
    for (;;) {
        
        pthread_mutex_lock(&thread->config.mtx);
        
        if (0 == thread->task_queue->count) {
            thread->status = tfthread_idle;
            pthread_cond_wait(&thread->config.cond, &thread->config.mtx);
        }
        else{
            pthread_mutex_lock(&thread->queue_mtx);
            tftask_t *run_task = pull_queue(thread->task_queue);
            

            pthread_mutex_unlock(&thread->queue_mtx);
            
            if (run_task) {
               
                tfmethod method = run_task->method;
                void *args = run_task->args;
                short *cancel_point = run_task->cancel_point;
                (method)(args, cancel_point);
                
                TFTASK_FREE(run_task);
            }
        }
        
        if (tfthread_suspend == thread->status) {
            printf("{ `tag`thread suspend in thread  }\n");
            pthread_cond_wait(&thread->config.cond, &thread->config.mtx);
        }
        else if (tfthread_dead == thread->status){
            ///issue:
            ///处理 dead thread
            break;
        }
        
        pthread_mutex_unlock(&thread->config.mtx);
    }
    
    
    pthread_mutex_unlock(&thread->config.mtx);
    return NULL;
}

void empty_run(void *a, short *b) {}

void tfthreadpool_init(tfthreadpool_t *threadpool, int count)
{
    assert(count > 0);
    tfthread_t **threads = malloc(count * sizeof(tfthread_t));
    threadpool->threads = threads;
    threadpool->count = count;
    for (int i = 0; i < count; ++i) {
        _tfthread_init(&threads[i]);
        
    }
}

void _tfthread_init(tfthread_t **thread){
    
    pthread_attr_t  attr;
    pthread_t       posix_t_id;
    
    pthread_attr_init(&attr);
    pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);
    
    *thread = (tfthread_t *)malloc(sizeof(tfthread_t));
    tftask_queue_t *queue = (tftask_queue_t *)malloc(sizeof(tftask_queue_t));
    queue->front = NULL;
    queue->rear = NULL;
    queue->count = 0;
    
    tfthread_config_t config = {PTHREAD_MUTEX_INITIALIZER, PTHREAD_COND_INITIALIZER};
    (*thread)->config = config;
    (*thread)->status = tfthread_idle;
    (*thread)->task_queue = queue;
    
    pthread_mutex_init(&(*thread)->queue_mtx, NULL);
    pthread_mutex_init(&(*thread)->task_free_mtx, NULL);
    
    pthread_create(&posix_t_id, &attr, tfthreadpool_task_run2, *thread);
    pthread_attr_destroy(&attr);
}

void tfthreadpool_free(tfthreadpool_t *threadpool)
{
    if (NULL == threadpool) return;
    
    if (NULL == threadpool->threads) {
        free(threadpool);
    } else {
        for (int i = 0; i < threadpool->count; ++i) {
            tfthread_t *free_thread = threadpool->threads[i];
            free_thread->status = tfthread_dead;
            pthread_cond_signal(&free_thread->config.cond);
            free(free_thread);
        }
        
        free(threadpool);
        threadpool = NULL;
    }
}

void *tfthread_once_fun(void *arg)
{
    tftask_t *task = (tftask_t *)arg;
    
    tfmethod method = task->method;
    
    (method)(task->args, task->cancel_point);
    
    TFTASK_FREE(task);
    
    pthread_exit(NULL);
}

void tfthread_once(tfmethod method, void *args, z_o_t* cancel_point)
{
    pthread_attr_t  attr;
    pthread_t       posix_t_id;
    
    *cancel_point = 0;
    tftask_t *task = (tftask_t *)malloc(sizeof(tftask_t));
    task->next = NULL;
    task->method = method;
    task->args = args;
    task->cancel_point = cancel_point;
    
    pthread_attr_init(&attr);
    
    pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);
    
    pthread_create(&posix_t_id, &attr, tfthread_once_fun, task);
    
    pthread_attr_destroy(&attr);
}



tfthread_t *tfthreadpool_idle_thread(tfthreadpool_t *threadpool)
{
    if (NULL == threadpool->threads) return NULL;
    
    tfthread_t  *thread_task_less = NULL;
    
    int task_count = 65535;
    
    for (int i = 0; i < threadpool->count; ++i) {
        tfthread_t *thread = threadpool->threads[i];
        if (thread->status >> 4) {
            thread->status = tfthread_inuse;
            return thread;
        }
        else{
            if (thread->task_queue->count < task_count) {
                task_count = thread->task_queue->count;
                thread_task_less = thread;
            }
        }
    }
    
    return thread_task_less;
}

void tfthreadpool_eat2(tfthreadpool_t *threadpool, tfmethod method, void *args)
{
    tfthread_t *thread = NULL;
    
    thread = tfthreadpool_idle_thread(threadpool);
    
    if (NULL == thread) {
        thread = threadpool->threads[0];
    }
    
    tftask_t *task = (tftask_t *)malloc(sizeof(tftask_t));
    
    if (NULL == task) {
        printf("{ fail to alloc task point, ingore and return\n }");
        return;
    }
    
    printf("~~~~~~~create task %p\n",task);
    
    TFTASK_INIT(task, method, args)
    z_o_t* cancel_point = (z_o_t*)calloc(4, 0);
    *cancel_point = 0;
    task->cancel_point = cancel_point;
    
    pthread_mutex_lock(&thread->queue_mtx);
    push_queue(thread->task_queue, task);
    
    pthread_mutex_unlock(&thread->queue_mtx);
    
    printf("{ threadpool %s running now }\n", threadpool->name);
    
    pthread_cond_signal(&thread->config.cond);
}

void tfthreadpool_suspend(tfthreadpool_t *threadpool)
{
    TFNULL_CHECK(threadpool->threads);
    
    for (int i = 0; i < threadpool->count; ++i) {
        printf("\n{ `tag`threadpool thread suspend }\n");
        tfthread_t *thread = threadpool->threads[i];
        thread->status = tfthread_suspend;
    }
}

void tfthreadpool_resume(tfthreadpool_t *threadpool)
{
    TFNULL_CHECK(threadpool->threads);
    
    for (int i = 0; i < threadpool->count; ++i) {
        printf("\n{ `tag`threadpool thread resume }\n");
        tfthread_t *thread = threadpool->threads[i];
        thread->status = tfthread_inuse;
        pthread_cond_signal(&thread->config.cond);
        
    }
}

void print_tfthreadpool_status(tfthreadpool_t *threadpool){
    for (int i = 0; i < threadpool->count; ++i) {
        tfthread_t *thread = threadpool->threads[i];
        printf("{ threadpool <%s> thread has tasks %d }\n",threadpool->name,thread->task_queue->count);
    }
}

count_t tfthreadpool_task_count(tfthreadpool_t *threadpool)
{
    count_t count = 0;
    
    for (int i = 0; i < threadpool->count; ++i) {
        tfthread_t *thread = threadpool->threads[i];
        count+=thread->task_queue->count;
    }
    
    return count;
}

