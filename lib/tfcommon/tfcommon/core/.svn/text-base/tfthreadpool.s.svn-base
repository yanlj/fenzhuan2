//
//  tfthreadpool.s
//  tfcommon
//
//  Created by yin shen on 3/11/13.
//
//


//.globl _tfthreadpool_idle_thread
//_tfthreadpool_idle_thread:
//    mov r5, 0xff
//    mov r4, #0
//Next:
//    ldr r1, [r0]        //tfthread_list
//    cmp r1, #0          //if (NULL == threadpool->thread_list)
//    beq NullReturn
//
//    ldrh r2, [r1, #4]   //tfthread_t->status
//    mov r3, r2, lsr #4  //tfthread_t->status>>4
//    cmp r3, #0          //if (thread_begin->status>>4)
//    bne FindIdle
//
//    ldr r2, [r1, #6]    //tfthread->task_count
//    cmp r2, r5
//    blt StoreLess
//
//    add r0, r1, #88     //threadpool->thread_list = threadpool->thread_list->next
//    cmp r0, #0
//    bne Next
//    mov r0, r4
//    mov pc, lr
//
//NullReturn:
//    mov r0, #0
//    mov pc, lr
//
//FindIdle:
//    mov r2, 0x01       //
//    strh r2, [r1, #4]   //tfthread_t->status = tfthread_inuse
//    mov r0, r1
//    mov pc, lr
//
//StoreLess:
//    mov r5, r2
//    mov r4, r1
