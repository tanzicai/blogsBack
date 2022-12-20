---
layout: pages
title: 倒计时小工具
date: 2021-09-19 16:59:06
top_img: https://gitee.com/tanzicai/drawingbed/raw/master/img/image-20210919182159053.png
cover: https://gitee.com/tanzicai/drawingbed/raw/master/img/image-20210919182159053.png
categories: Java
tags:	
   - 时钟
   - 倒计时
---
# README

该小程序完成了一个简单的倒计时项目，实现功能如下

+ 倒计时设定
  + 加1小时/减1小时
  + 加1分钟/减1分钟
  + 加1秒钟/减1秒钟
+ 功能设定
  + 开始
  + 暂停
  + 停止
  + 复位

# 各类设计

## class MicroWave

```java
import java.util.Timer;
import java.util.TimerTask;
public class MicroWave extends Thread{
    private int hour;//小时数
    private int minutes;//分钟数
    private int second;//秒数
    private boolean isRun;//是否正在运行

    public MicroWave() {
        hour = 0;
        minutes = 0;
        second = 0;
        isRun = false;
    }

    @Override
    public void run() {
        Timer timer = new Timer();
        timer.schedule(new TimerTask() {
            @Override
            public void run() {

                //如果正在运行就改变时间
                if (isRun) {
                    if (second >= 1) {
                        second--;
                    } else {
                        second = 59;
                        if (minutes >= 1) {
                            minutes--;
                        } else {
                            minutes = 59;
                            if (hour >= 1) {
                                hour--;
                            } else {
                                hour = 0;
                                minutes = 0;
                                second = 0;
                                isRun = false;
                            }
                        }
                    }
                }
            }
        },0,1000);
    }

    public int getHour() {
        return hour;
    }

    public void addHour(int hour) {
        this.hour += hour;
    }

    public int getMinutes() {
        return minutes;
    }

    public void addMinutes(int minutes) {
        this.minutes += minutes;

        if (this.minutes == 60) {
            this.minutes = 0;
            this.hour++;
        }
    }

    public int getSecond() {
        return second;
    }

    public void setHour(int hour) {
        this.hour = hour;
    }

    public void setMinutes(int minutes) {
        this.minutes = minutes;
    }

    public void setSecond(int second) {
        this.second = second;
    }

    public void addSecond(int second) {

        this.second += second;

        if (this.second == 60) {
            this.second = 0;
            minutes++;
            if (minutes == 60) {
                minutes = 0;
                hour++;
            }
        }
    }

    public void setIsRun(boolean isRun) {
        this.isRun = isRun;
    }

    public boolean isRun() {
        return isRun;
    }
}

```

## MicroWaveMain

```java
import java.util.Timer;
import java.util.TimerTask;

public class MicroWaveMain {
    public static void main(String[] args) {
        final MicroWave microWave = new MicroWave();
        final MicroWaveWindow microWaveWindow = new MicroWaveWindow(microWave);

        microWave.run();
        Timer timer = new Timer();
        timer.schedule(new TimerTask() {
            @Override
            public void run() {
                microWaveWindow.setTimeLable(microWave.getHour(), microWave.getMinutes(),microWave.getSecond());
                microWaveWindow.pack();//动态调整窗口大小
            }
        },0,50);
    }
}
```

## MicroWaveWindow

```java
import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;

public class MicroWaveWindow extends JFrame{

    JLabel timeLable;//倒计时的时间标签

    public void setTimeLable(int hour,int minutes,int second) {
        String hourStr = String.format("%2d",hour);
        String minutesStr = String.format("%2d",minutes);
        String secondStr = String.format("%2d", second);

        hourStr = hourStr.replace(' ','0');
        minutesStr = minutesStr.replace(' ','0');
        secondStr = secondStr.replace(' ','0');

        this.timeLable.setText(hourStr + ":" + minutesStr + ":" + secondStr);
    }

    //传入它控制的微波炉
    public MicroWaveWindow(final MicroWave microWave) {
        this.setTitle("微波炉仿真程序");
        this.addWindowListener(new WindowAdapter() {
            @Override
            public void windowClosing(WindowEvent e) {
                System.exit(0);
            }
        });

        JPanel upPanel = new JPanel();
        JPanel midPanel = new JPanel();
        JPanel downPanel = new JPanel();
        this.setLayout(new BorderLayout());
        this.add(upPanel, BorderLayout.NORTH);
        timeLable = new JLabel();
        upPanel.add(timeLable);
        timeLable.setFont(new Font("Dialog", 1, 100));
        timeLable.setText(microWave.getHour() + ":" + microWave.getMinutes() + ":" + microWave.getSecond());

        this.add(midPanel, BorderLayout.CENTER);
        midPanel.setLayout(new BorderLayout());
        JPanel midUpPanel = new JPanel();
        JPanel midDownPanel = new JPanel();
        midPanel.add(midUpPanel,BorderLayout.NORTH);
        midPanel.add(midDownPanel,BorderLayout.SOUTH);

        JLabel fire = new JLabel("火力");
        JRadioButton bigFire = new JRadioButton("大火");
        JRadioButton midFire = new JRadioButton("中火");
        JRadioButton smallFire = new JRadioButton("小火");
        midUpPanel.add(fire);
        midUpPanel.add(bigFire);
        midUpPanel.add(midFire);
        midUpPanel.add(smallFire);

        ButtonGroup buttonGroup = new ButtonGroup();
        buttonGroup.add(bigFire);
        buttonGroup.add(midFire);
        buttonGroup.add(smallFire);

        JLabel addTime = new JLabel("时间");
        midDownPanel.add(addTime);
        JButton addHour = new JButton("+1小时");
        JButton addMinutes = new JButton("+1分钟");
        JButton addSecond = new JButton("+1秒");
        midDownPanel.add(addHour);
        midDownPanel.add(addMinutes);
        midDownPanel.add(addSecond);

        addHour.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                microWave.addHour(1);
            }
        });
        addMinutes.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                microWave.addMinutes(1);
            }
        });
        addSecond.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                microWave.addSecond(1);
            }
        });


        this.add(downPanel, BorderLayout.SOUTH);
        JLabel function = new JLabel("功能");
        JButton startButton = new JButton("开始");
        JButton pauseButton = new JButton("暂停");
        JButton stopButton = new JButton("停止");
        downPanel.add(function);
        downPanel.add(startButton);
        downPanel.add(pauseButton);
        downPanel.add(stopButton);

        startButton.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                if (microWave.getHour() == 0 && microWave.getMinutes() == 0 && microWave.getSecond() == 0) {
                    JOptionPane.showMessageDialog(null,"时间为0!");
                } else {
                    microWave.setIsRun(true);
                }
            }
        });

        pauseButton.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                microWave.setIsRun(false);
            }
        });

        stopButton.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                microWave.setIsRun(false);
                microWave.setHour(0);
                microWave.setMinutes(0);
                microWave.setSecond(0);
            }
        });

        this.pack();
        this.setLocationRelativeTo(null);
        this.setResizable(false);
        this.setVisible(true);
    }
}

```

# 代码解析

```
public class Timer extends Object
```

用于将任务安排在后台线程中用于未来执行的工具。任务可以安排为一次性执行，或定期重复执行。

与每个`Timer`对象相对应的是一个单一的背景线程，用于按顺序执行时间器的所有任务。时间器任务应快速完成。如果一个时间器任务需要过多的时间来完成，它"记录"了时间器的任务执行线程。这反过来又会延迟后续任务的执行，这些任务可能会"捆扎"起来，并在（如果）违规任务最终完成时快速连续执行。

在最后一次对`定时器`对象的实时引用消失所有未完成的任务完成执行后，定时器的任务执行线程优雅地终止（并成为垃圾收集的对象）。然而，这可能需要很长的时间才能发生。默认情况下，任务执行线程不会作为*守护神线程*运行，因此它能够阻止应用程序终止。如果呼叫者想要快速终止计时器的任务执行线程，呼叫者应调用计时器的`取消`方法。

例如，如果计时器的任务执行线程意外终止，因为其`停止`方法被调用，则任何在计时器上安排任务的进一步尝试都将导致`非法状态例外`，就好像调用了计时器的`取消`方法一样。

此类是线程安全的：多个线程可以共享单个`计时器`对象，而无需外部同步。

此类*不*提供实时保证：它使用`对象安排`任务。

Java 5.0 介绍了该包，其中一个并发公用设施是[`计划ThreadPool执行器`](https://docs.oracle.com/javase/8/docs/api/java/util/concurrent/ScheduledThreadPoolExecutor.html)，它是一个线程池，用于以给定速度或延迟重复执行任务。它实际上是一个多功能的替代/组合，因为它允许多个服务线程，接受不同的时间单位，不需要子分类（只是实现）。用一个线程进行配置，就等于。`java.util.concurrent``Timer``TimerTask``TimerTask``Runnable``ScheduledThreadPoolExecutor``Timer`

实施说明：此类将规模扩展到大量并发计划的任务（数千个任务应该不构成问题）。在内部，它使用二进制堆来表示其任务队列，因此安排任务的成本是 O（log n），其中 n 是并发计划任务的数。

实施说明：所有构造器启动时器线程。

| `void` | `cancel()`终止此定时器，丢弃当前计划的任何任务。             |
| ------ | ------------------------------------------------------------ |
| `int`  | `purge()`从此时间器的任务队列中删除所有已取消的任务。        |
| `void` | `schedule(TimerTask task, Date time)`在指定时间安排执行指定任务。 |
| `void` | `schedule(TimerTask task, Date firstTime, long period)`安排指定任务，以便从指定时间开始重复*固定延迟执行*。 |
| `void` | `schedule(TimerTask task, long delay)`在指定延迟后安排指定的任务执行。 |
| `void` | `schedule(TimerTask task, long delay, long period)`安排指定任务，以便重复*固定延迟执行*，从指定延迟后开始。 |
| `void` | `scheduleAtFixedRate(TimerTask task, Date firstTime, long period)`安排指定任务，以便从指定时间开始重复*固定速率执行*。 |
| `void` | `scheduleAtFixedRate(TimerTask task, long delay, long period)`安排指定任务，以便重复*固定速率执行*，从指定延迟后开始。 |

```
 public abstract class TimerTask
 extends Object
 implements Runnable
```

  可以一次性安排或由定时器重复执行的任务。

| 修饰语      | 构造器和描述                      |
| :---------- | :-------------------------------- |
| `protected` | `TimerTask()`创建新的时间器任务。 |

| 修饰器和类型    | 方法和描述                                                   |
| :-------------- | :----------------------------------------------------------- |
| `boolean`       | `cancel()`取消此时间器任务。                                 |
| `abstract void` | `run()`此定时器任务将执行的操作。                            |
| `long`          | `scheduledExecutionTime()`返回此任务最近*实际*执行的*预定*执行时间。 |