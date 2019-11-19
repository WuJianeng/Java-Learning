# Java多线程



## 1	Java并行程序基础



### 1.1	线程的基本操作

#### 1.1.1	新建线程

```java
Thread t1 = new Thread();
t1.start();
```

线程执行start()方法后，会在新建一个线程并并让这个线程执行run()方法。



```java
Thread t1 = new Thread();
t1.run();
```

这种方式也可以运行，但是会在当前线程串行执行run()方法中的代码。

**线程池当中有应用**



```java
Thread t1 = new Thread(){
	@Override
	public void run(){
		System.out.println("Hello, I am t1");
	}
};
t1.start(0);
```

上面使用匿名内部类，重写run()方法，在线程运行时会打印字符串。



也可以使用Runnable接口完成操作，Runnable接口只有一个run()方法。

```java
public interface Runnable{
    public abstract void run();
}
```

Thread有一个构造方法;

```java
public Thread(Runnable target)
```

它会传入一个Runnable接口的实例，在start（）方法调用时，新的线程会执行Runnale.run()方法。

#### 1.1.2	终止线程

Thread.stop()方法在结束线程时，会直接终止线程，并立即释放这个线程所持有的锁。

**stop()方法已经被标记为废弃的方法。**

解决办法：

提供一个提醒线程该任务的变量，当任务执行时，循环终止条件与该变量有关。当需要停止线程的执行时，将变量设为终止状态，执行的任务