# Scheduling
Het probleem van scheduling is het toewijzen van taken aan resources.

## Cooporative scheduling

- Superloop 'scheduler'

### Superloop construct
- Simple, deterministic
- Fixed time scheduling using SysTick
- sleep until next SysTick (save energy)

# Arm Cortex-M4
has:
- sistyck peripheral
- systick interrupt handler

Systick is meant to be used for scheduling
In de cpu core
- 24 bit tick
- own 

Blocking tasks will cause problems

# Overview
- Tasklist
    - Structure for each task
    - Ordered by priority
    - Only execute task when ready

- Use SysTick to determine which task ik READy
- Use main loop to execute all ready tasks
- Sleep until next SystTick

##
```c
// Syntax
void func(int); 
void (*pointerNaarFunc)(int);

// To run
pointerNaarFunc = &func;
(*pointerNaarFunc)(42);

// To run (alternative)
pointerNaarFunc = func;
pointerNaarFunc(42);
```

# Suspending a task
Implementing a delay using SysTick
- Change state to WAITING
- Initialize a counter, or add to the existing period
- Decrement the counter each tick
- When reached zero, put into ready mode


# Scheduling
The process of selecting the task to execute next
- What if 3 tasks are READY at the same time?
- Which one will be selected first?

Scheduling algorithms
- FIFO (Round robin)
- Priority based

## FIFO - Sheduling
Tasks are run in order of task-creation
- Add most important tasks first
- Add less important tasks later

Pro
- Easy!
- No overhead in selecting
Con
- Fixed solution, pre-determined at compile time
- Tasks created run-time are always last

## Priority based scheduling
Use ‘priority’ number over position in task list
Highest priority task goes first of all READY tasks

Pro
- Ability to work with more tasks
- Possible to change priority real time
- Most demanding tasks run first
Cons
- Means either sorting a list or traversing it 
- Increases scheduling time

# TODO
Make a 'Complex' Cooperative Scheduler
Adaptation to a simple version:
- Each task gets its own periond (e.g. 400 SysTicks)
- Each task gets its own priority, state, etc

