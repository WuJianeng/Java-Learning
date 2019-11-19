# Android 开发

**<u>本笔记参考自《第一行代码 Android》第二版和《疯狂Android讲义》第四版</u>**

## 0	Android应用和开发环境

****

机使用的是基于VirtualBox的Genymotion安卓虚拟机环境，电脑CPU为AMD Ryzen 7 2700，支持SVM虚拟化技术，但是不能使用Android Studio自带的虚拟机AVM。

使用的IDE为Android Studio开发环境。

电脑CPU AMD Ryzen 7 2700八核

显卡: AMD Radeon RX 580 Series 

内存：DDR4 8/16GB

固态SSD：256GB

机械硬盘：1TB。

### 0.1	添加依赖

![1570603633708](C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1570603633708.png)

输入完成后主界面右上角会提示`Sync Now`，提示进行同步，点击一下就行。



#### 0.2	安装Apache服务器

1）httpd.conf中路径需要更改

2）install后服务需要启动

3）看看端口是否被占用，占用则换端口8080、8081等

4）关闭防火墙

![1570882672525](C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1570882672525.png)

![1570882606568](C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1570882606568.png)



## 1	开始第一个Android应用	

### 1.1	开始第一个Android应用

开发Android应用主要分为以下三步：

**1）**	创建一个Android项目或者Android模块

**2）**	在XML布局文件中定义应用程序的用户界面

**3）**	在Java或Kotlin代码中编写业务实现

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1569334426869.png" alt="1569334426869" style="zoom: 33%;" />

## 2	活动

任何活动（`Activity`）都需要继承`onCreate`方法。

### 2.1	主活动

对于任何一个应用程序，都必须有一个主活动，即当程序运行起来时，首先要启动的活动。

配置方法为：

在`AndroidManifest.xml`文件中进行注册并声明为主活动

```xml
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.example.activitytest">

    <application
        android:allowBackup="true"
        android:icon="@mipmap/ic_launcher"
        android:label="@string/app_name"
        android:roundIcon="@mipmap/ic_launcher_round"
        android:supportsRtl="true"
        android:theme="@style/AppTheme">
        <activity android:name=".FirstActivity">
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
    </application>

</manifest>
```

在`Activity`标签中，对活动进行注册。

```xml
<activity android:name=".FirstActivity"></activity>
```

在`Activity`标签内部加入`<intent-filter>`标签，并添加

`<action android:name="android.intent.action.MAIN"/>` 

`<category android:name="android.intent.category.LAUNCHER"/>`

这两句声明即可。

还可以使用`android:label`指定标题栏的内容

### 2.2	在活动中使用`Toast`

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1570435979436.png" alt="1570435979436" style="zoom: 50%;" />

使用`Toast`可以将一些短小的信息通知给用户，这些信息在一段时间之后就会消失。

### 2.3	使用`Intent`在活动之间切换

`Intent`的作用：

启动活动、启动服务、发送广播

`Intent`分类：

显式`Intent`、隐式`Intent`

#### 2.3.1	显式`Intent`

```java
Button button1 = (Button) findViewById(R.id.button_1);
        button1.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View v){
               Intent intent = new Intent(FirstActivity.this, SecondActivity.class);
               startActivity(intent);
            }
        });
```



#### 2.3.2	隐式`Intent`

```java
button1.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View v){
               Intent intent = new Intent("com.example.activitytest.ACTION_START");
               intent.addCategory("com.example.activitytest.MY_CATEGORY");
               startActivity(intent);
            }
        });
```

使用隐式`Intent`还可以启动其他程序的活动，这使得`Android`多个应用程序之间的功能共享成为可能。

当需要在应用程序中展示网页时，可以调用系统的浏览器来打开网页：

```java
button1.setOnClickListener(new View.onClickListener(){
    @Override
    public void onClick(View v){
        Intent intent = new Intent(Intent.ACTION_VIEW);
        intent.setData("Uri.parse("http://www.baidu.com")");
        startActivity(intent);
    }
})
```

#### 2.3.3	给每一个活动增加启动方法

在多人协同完成一个项目时，会出现不同的`Activity`由不同的开发者创建，而这些`Activity`存在着启动与被启动的关系。

当它们之间需要传递参数时，往往通过下面的方式：

```java
Intent intent = new Intent(FirstActivity.this, SecondActivity.class);
intent.putExtra("param1", "data1");
intent.putExtra("param2", "data2");
startActivity(intent);
```

当需要启动`SecondActivity`而不知道需要哪些参数（名称和数目）时，可能需要询问开发`SecondActivity`的人其参数类型。

这个可以由`SecondActivity`开发者提供启动活动的静态函数来实现参数的传递，而不需要关心参数的命名：

```java
public SecondActivity extends BaseActivity{
    ...
    public static void actionStart(Context context, String data1, String data2){
        Intent intent = new Intent(context, SecondActivity.class);
        intent.putExtra("param1", data1);
        intent.putExtra("param2", data2);
        startActivity(intent);
    }
}
```

这样开发`FirstActivity`的人就不需要关注启动`SecondActivity`需要传递的参数名称了，只需要调用`SecondActivity`的`actionStart`方法，将本活动和数据传递进去即可：

```java
public FirstActivity extends BaseActivity{
    ...
    @Override
    public void onCreate(Bundle savedInstanceState){
        super.onCreate(savedInstanceState);
        setContentView(R.layout.first_layout);
        Button button1 = (Button) findViewById(R.id.button_1);
        button1.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View v){
                SecondActivity.actionStart(FirstActivity.this, "data1", "data2");
            }
        })
    }
}
```

因此，作为`FirstActivity`的开发者，无需关注`SeconActivity`启动传递参数的具体细节，即不需要知道启动时参数名称。

作为`SecondActiviy`的开发者，在可以根据自己定义的启动时传递的参数名称来获取相关的 数据。

## 3	UI开发

****

### 3.1	编写程序界面

1)	通过可视化工具直接编写

优点：直观简单

缺点：屏幕适配性不好，不适合复杂的界面设计，不推荐

2）	通过编辑xml文件编写

优点：屏幕适配性好，适合复杂的界面编辑

缺点：不够直观，学习曲线稍陡

### 3.2	常用控件

`TextView`：显示文本的基本控件

`Button`：按钮，是程序用于与用户交互的重要控件

`EditText`：用于交互的另一重要控件，允许用户在空间里输入和编辑内容，并可以在程序中对这些内容进行处理

`ImageView`：用于在界面上展示图片的控件

`ProgressBar`：用于在界面上显示进度条

`AlterDialog`：在当前界面弹出一个对话框，这个对话框是置于所有界面之上的，可以屏蔽掉其他控件的交互能力在界面上弹出对话框，可以屏蔽掉其他控件的交互能力。

`ProgressDialog`：在界面弹出一个对话框并屏蔽掉其他控件的交互能力。它会显示一个进度条，一般用于操作比较耗时，需要用户耐心等待。

#### 3.2.1	`TextView`

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:orientation="vertical"
    android:layout_width="match_parent"
    android:layout_height="match_parent">

    <TextView
        android:layout_width="match_parent"	//宽度与父布局一致
        android:layout_height="wrap_content"//高度由控件内容大小决定
        android:id="@+id/text_view"	//控件唯一标识符
        android:gravity="center"	//对齐方式
        android:text="This is TextView"	//文本内容
        android:textSize="24sp"		//文字大小
        android:textColor="#00ff00"	//文字颜色
        />

</LinearLayout>
```

`android:layout_width`:指定了控件的宽度

`android:layout_height`：指定了控件的高度

其可选的参数有：

`match_parent`/`fill_parent`:它们含义相同，表示让当前控件的大小和父布局一样，官方推荐使用`match_parent`

`wrap_content`:表示让当前控件的大小能够刚好包含住里面的内容，也就是控件的内容决定控件大小

除此之外，还可以指定控件大小，当然这样做的屏幕适配性不好

`android:text`:指定了`TextView`中显示的文本内容。

`android:gravity`:指定文字的对齐方式，可选值有：`top,bottom,left,right,center`等，可以用`|`来同时指定多个值

此时`android:gravity="center"`等于`android:gravity="center_vertical | center_horizontal"`

#### 3.2.2	`Button`

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:orientation="vertical"
    android:layout_width="match_parent"
    android:layout_height="match_parent">

    <Button
        android:id="@+id/button"	//唯一标识符
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:text="Button"		//显示的文字
        />

</LinearLayout>
```

注意：系统会默认对`Button`中显示的所有英文字母**自动进行大写转换**，可以采用下面的方式禁用：

`android:textAllCaps="false"`

可以在`Activity`中为`Button`的点击事件注册一个监听器：

```java
public calss MainActivity extends AppCompatAcitivy{
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Button button = (Button) findViewById(R.id.button);
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                //在此处添加点击事件发生时，所需要进行的操作
            }
        });
    }
}
```

当处于`MainActivity`活动时，若在界面上点击该`Button`，则会触发该`onClick`方法。

#### 3.2.3	`EditText`

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1570455951156.png" alt="1570455951156" style="zoom:50%;" />

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:orientation="vertical"
    android:layout_width="match_parent"
    android:layout_height="match_parent">
    
    <EditText
        android:id="@+id/edit_text"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:hint="type something here"	//提示性的文字，在用户输入时会消失
        android:maxLines="2"	//输入的最大行为2，超过的内容就会向上滚动
        />

</LinearLayout>
```

![1570456158401](C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1570456158401.png)

对方输入超过两行时，产生滚动，不再扩展行。



将上面两个控件结合，使得由`EditText`输入，`Button`触发将`EditText`存有的文本输出到屏幕

```java
public class MainActivity extends AppCompatActivity {

    private EditText editText;	//活动拥有EditText对象

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Button button = (Button) findViewById(R.id.button);
        editText = (EditText) findViewById(R.id.edit_text);//初始化对象，其引用控件R.id.edit_text
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String text = editText.getText().toString();//得到editText存储的文本
                Toast.makeText(MainActivity.this, text, Toast.LENGTH_SHORT).show();	//在MainActivity活动中显示文本内容
            }
        });
    }
}

```

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1570456456033.png" alt="1570456456033" style="zoom:50%;" />

#### 3.2.4	`ImageView`

使用该控件需要准备图片，通常放在`res/drawble`目录下

由于该目录没有指定分辨率，因此一般不用它来存放图片

这儿在`res`目录下面新建`drawable-xhdpi`目录，然后将准备好的图片复制到该目录下

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:orientation="vertical"
    android:layout_width="match_parent"
    android:layout_height="match_parent">

	...
    <ImageView
        android:id="@+id/image_view"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:src="@drawable/img_1"	//给ImageView指定一张图片
        />

</LinearLayout>
```

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1570458313829.png" alt="1570458313829" style="zoom:50%;" />

可以设置点击按钮之后更换照片：

```java
public class MainActivity extends AppCompatActivity {

    private EditText editText;
    private ImageView imageView;	//拥有ImageView类对象

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Button button = (Button) findViewById(R.id.button);
        editText = (EditText) findViewById(R.id.edit_text);
        imageView = (ImageView) findViewById(R.id.image_view);//初始化
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                imageView.setImageResource(R.drawable.img_2);//更换图片
            }
        });
    }
}

```

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1570458481484.png" alt="1570458481484" style="zoom:50%;" />

#### 3.2.5	`Progressbar`

在界面上显示一个进度条，表示程序正在加载一些数据

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:orientation="vertical"
    android:layout_width="match_parent"
    android:layout_height="match_parent">

    ...
    <ProgressBar
        android:id="@+id/progress_bar"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        />

</LinearLayout>
```

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1570458715045.png" alt="1570458715045" style="zoom: 67%;" />

`android:visibility`指定控件的可见性

可选值：

`visible`：控件可见

`invisible`：控件不可见，但仍然占据屏幕空间

`gone`：控件不可见，并且不占用屏幕空间

还可以通过代码控制屏幕的可见性：

```java
public class MainActivity extends AppCompatActivity {

    private EditText editText;
    private ImageView imageView;
    private ProgressBar progressBar;	//拥有ProgressBar类对象

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Button button = (Button) findViewById(R.id.button);
        editText = (EditText) findViewById(R.id.edit_text);
        imageView = (ImageView) findViewById(R.id.image_view);
        progressBar = (ProgressBar) findViewById(R.id.progress_bar);//初始化
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                imageView.setImageResource(R.drawable.img_2);
                //对progressBar的可见性进行查询并改变可见性
                if(progressBar.getVisibility() == View.GONE){
                    progressBar.setVisibility(View.VISIBLE);
                }else{
                    progressBar.setVisibility(View.GONE);
                }
            }
        });
    }
}

```

可以改变进度条的样式：

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:orientation="vertical"
    android:layout_width="match_parent"
    android:layout_height="match_parent">

   ...
    <ProgressBar
        android:id="@+id/progress_bar"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        style="?android:attr/progressBarStyleHorizontal" //水平进度条
        android:max="100" //最大值为100
        />

</LinearLayout>
```

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1570459554123.png" alt="1570459554123" style="zoom:67%;" />

通过`progressBar.setProgress`方法改变进度条的进度：

```java
public class MainActivity extends AppCompatActivity {

    private EditText editText;
    private ImageView imageView;
    private ProgressBar progressBar;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Button button = (Button) findViewById(R.id.button);
        editText = (EditText) findViewById(R.id.edit_text);
        imageView = (ImageView) findViewById(R.id.image_view);
        progressBar = (ProgressBar) findViewById(R.id.progress_bar);
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                imageView.setImageResource(R.drawable.img_2);
                int progress = progressBar.getProgress();
                if(progress == 100){
                    progressBar.setVisibility(View.GONE);
                }
                progress += 10;
                progressBar.setProgress(progress);	//改变进度条进度
            }
        });
    }
}

```

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1570459736181.png" alt="1570459736181" style="zoom:67%;" />

#### 3.2.6	`AlertDialog`

可以在当前的界面弹出一个对话框，并且屏蔽其他控件的交互能力

```java
public class MainActivity extends AppCompatActivity {

    private EditText editText;
    private ImageView imageView;
    private ProgressBar progressBar;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Button button = (Button) findViewById(R.id.button);
        editText = (EditText) findViewById(R.id.edit_text);
        imageView = (ImageView) findViewById(R.id.image_view);
        progressBar = (ProgressBar) findViewById(R.id.progress_bar);
        Button button_2 = (Button) findViewById(R.id.button_2);
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                imageView.setImageResource(R.drawable.img_2);
                int progress = progressBar.getProgress();
                if(progress == 100){
                    progressBar.setVisibility(View.GONE);
                }
                progress += 10;
                progressBar.setProgress(progress);
            }
        });
        button_2.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {	//Button_2点击触发的事件
                AlertDialog.Builder dialog = new AlertDialog.Builder(MainActivity.this );	//创建AlertDialog实例
                dialog.setTitle("This is a dialog");//标题
                dialog.setMessage("Warning!");	//内容
                dialog.setCancelable(false);	//可否用BACK键（返回键）关闭
                dialog.setPositiveButton("OK", new DialogInterface.OnClickListener() {//确定按钮命名为"OK",以及相应的点击事件
                    @Override
                    public void onClick(DialogInterface dialog, int which) {

                    }
                });
                dialog.setNegativeButton("Cancel", new DialogInterface.OnClickListener() {//取消按钮命名为"Cancel",以及相应的点击事件
                    @Override
                    public void onClick(DialogInterface dialog, int which) {

                    }
                });
                dialog.show();	//显示AlertDialog
            }
        });
    }
}

```

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1570526495931.png" alt="1570526495931" style="zoom:67%;" />



#### 3.2.7	`ProgressDialog`

在界面上弹出对话框，并屏蔽其他控件的交互能力，同时会在对话框中显示进度条。

```java
 Button button_3 = (Button) findViewById(R.id.button_3);
        button_3.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                ProgressDialog progressDialog = new ProgressDialog(MainActivity.this);
                progressDialog.setCancelable(true);
                progressDialog.setTitle("ProgressDialog");
                progressDialog.setMessage("Waiting!");
                progressDialog.show();
            }
        });
```

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1570527022923.png" alt="1570527022923" style="zoom:67%;" />



### 3.3	4种基本布局

****

布局是一种可用于放置很多控件的容器，可以按照一定的规律调整内部控件的位置。**布局内部还可以放置布局**

#### 3.3.1	线性布局（`LinearLayout`）

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:orientation="vertical"	//内部控件的排列方向，vertical为垂直方向，horizontal为水平方向
    android:layout_width="match_parent"
    android:layout_height="match_parent">

    <TextView
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:id="@+id/text_view"
        android:gravity="center"	//控件内部文字在控件中的对齐方式
        android:layout_gravity="center"//控件在布局中的对齐方式
        android:text="This is TextView"
        android:textSize="24sp"
        android:textColor="#000000"
        />
    <Button
        android:id="@+id/button"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:text="Button"
        android:textAllCaps="false"
        />
    <EditText
        android:id="@+id/edit_text"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:hint="type something here"
        android:maxLines="2"
        />
    
</LinearLayout>
```

通过`android:layout_weight`允许使用比例的方式来指定控件的大小

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:orientation="horizontal"	//水平方向
    android:layout_width="match_parent"
    android:layout_height="match_parent">

    <EditText
    android:id="@+id/input_message"
    android:layout_width="0dp"
    android:layout_height="wrap_content"
    android:layout_weight="1"	//权重为1，最终宽度占比50%
    android:hint='type something'/>
    <Button
        android:id="@+id/button1"
        android:layout_width="0dp"
        android:layout_height="wrap_content"
        android:layout_weight="1"	//权重为1，最终宽度占比50%
        android:layout_gravity="top"
        android:text="Button 1"/>
    
</LinearLayout>
```

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1570530901950.png" alt="1570530901950" style="zoom:80%;" />

只有`EditText`使用权重方式，`Button`的`layout_width`使用`wrapcontent`，则`EditText`将占满生育所有的宽度

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1570531098866.png" alt="1570531098866" style="zoom:80%;" />

#### 3.3.2	相对布局（`RelativeLayout`）

```xml
<?xml version="1.0" encoding="utf-8"?>
<RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent">

    <Button
        android:id="@+id/button1"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_alignParentLeft="true"
        android:layout_alignParentTop="true"
        android:text="Button 1"/>
    <Button
        android:id="@+id/button2"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_alignParentTop="true"
        android:layout_alignParentRight="true"
        android:text="Button 2"/>
    <Button
        android:id="@+id/button3"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_centerInParent="true"
        android:text="Button 3"/>
    <Button
        android:id="@+id/button4"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_alignParentBottom="true"
        android:layout_alignParentLeft="true"
        android:text="Button 4"/>
    <Button
        android:id="@+id/button5"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_alignParentBottom="true"
        android:layout_alignParentRight="true"
        android:text="Button 5"/>
</RelativeLayout>
```

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1570531464529.png" alt="1570531464529" style="zoom:80%;" />

`Button1`与父布局的左上角对其

上述是相对于父布局进行的对齐方式，下面介绍相对于控件进行对齐的方式

```xml
<?xml version="1.0" encoding="utf-8"?>
<RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent">

    <Button
        android:id="@+id/button3"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_centerInParent="true"
        android:text="Button 3"/>
    <Button
        android:id="@+id/button1"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_above="@id/button3"
        android:layout_toLeftOf="@id/button3"
        android:text="Button 1"/>
    <Button
        android:id="@+id/button2"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_above="@id/button3"
        android:layout_toRightOf="@id/button3"
        android:text="Button 2"/>
    <Button
        android:id="@+id/button4"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_below="@id/button3"
        android:layout_toLeftOf="@id/button3"
        android:text="Button 4"/>
    <Button
        android:id="@+id/button5"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_below="@id/button3"
        android:layout_toRightOf="@id/button3"
        android:text="Button 5"/>
</RelativeLayout>
```

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1570531858947.png" alt="1570531858947" style="zoom:80%;" />

#### 3.3.3	帧布局（`FrameLayout`）

这种布局没有默认的定位方式，所有的控件都会默认的摆放在布局的左上角

```xml
<?xml version="1.0" encoding="utf-8"?>
<FrameLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent">

    <TextView
        android:id="@+id/text_view"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_gravity="left"
        android:text="This is TextView"/>
    <ImageView
        android:id="@+id/image_view"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_gravity="right"
        android:src="@mipmap/ic_launcher"/>
</FrameLayout>
```

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1570532336275.png" alt="1570532336275" style="zoom:80%;" />

3.3.4	百分比布局

百分比布局分为`PercentFrameLayout`和`PercentRelativeLayout`

由于`LinearLayout`本身已经支持按比例布局，因此只有`FrameLayout`和`PercentRelativeLayout`需要扩展按比例布局

**百分比布局属于新增布局，因此需要添加相关依赖：**

Android团队将百分比布局定义在了`support`库中，需要在项目的`build.gradle`中添加百分比布局的依赖

打开`app/build.gradle`文件，在`denpendencies`闭包中添加下面内容

```xml
dependencies{
	compile 
}
```

...



### 3.4	创建自定义控件

****

所有的控件都直接或者间接的继承自`View`的，所有的布局都直接或者间接地继承自`ViewGroup`

`View`是最基本的UI组件，它可以在屏幕上绘制一块矩形区域，并能够响应这块区域的各种事件。

而`ViewGroup`则是一种特殊的`View`，它可以包含很多子`View`和子`ViewGroup`，是一个用于放置控件和布局的容器。

#### 3.4.1	引入布局

定义一个布局`title.xml`

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:background="@drawable/title_bg">

    <Button
        android:id="@+id/title_back"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_gravity="center"
        android:layout_margin="5dp"
        android:background="@drawable/back_bg"
        android:text="Back"
        android:textColor="#fff"/>

    <TextView
        android:id="@+id/title_text"
        android:layout_width="0dp"
        android:layout_height="wrap_content"
        android:layout_weight="1"
        android:layout_gravity="center"
        android:gravity="center"
        android:text="Title Text"
        android:textColor="#fff"
        android:textSize="24sp"/>

    <Button
        android:id="@+id/title_edit"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_gravity="center"
        android:layout_margin="5dp"
        android:background="@drawable/edit_bg"
        android:text="Edit"
        android:textColor="#fff"/>

</LinearLayout>
```

在布局`activity_main.xml`中引用上面的自定义布局

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent">

    <include layout="@layout/title" />	//引用布局title.xml
</LinearLayout>
```

效果：

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1570539047277.png" alt="1570539047277" style="zoom:67%;" />

#### 3.4.2	创建自定义控件

如果引入的自定义布局中需要有一些交互功能，则最好使用自定义控件的方式

先新建一个`TitleLayout`继承自`LinearLayout`，让它成为我们的自定义标题栏控件：

```java
public class TitleLayout extends LinearLayout {

    public TitleLayout(Context context, AttributeSet attrs){
        super(context, attrs);
        LayoutInflater.from(context).inflate(R.layout.title, this);
    }
}
```



这样在布局文件中就可以添加这个自定义控件：

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent">

    <com.example.uicustomviews.TitleLayout	//添加自定义控件
        android:layout_width="match_parent"
        android:layout_height="wrap_content"/>

</LinearLayout
```

可以在`TitleLayout`的类文件中为按钮注册点击事件：

```java
public class TitleLayout extends LinearLayout {

    public TitleLayout(Context context, AttributeSet attrs){
        super(context, attrs);
        LayoutInflater.from(context).inflate(R.layout.title, this);
        Button titleBack = (Button) findViewById(R.id.title_back);
        Button titleEdit = (Button) findViewById(R.id.title_edit);
        titleBack.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View v) {
                ((Activity) getContext()).finish();
            }
        });
        titleEdit.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View v) {
                Toast.makeText(getContext(), "You clicked Edit button",
                        Toast.LENGTH_SHORT).show();
            }
        });
    }
}
```



### 3.5	最常用和最难用的控件——`ListView`

`ListView`控件允许用户通过手指上下滑动的方式将屏幕外的数据滚动到屏幕内，同时屏幕上原来的数据会滚动出屏幕。

#### 3.5.1	`ListView`的简单用法

在`activity_main.xml`中添加`ListView`控件：

```xml
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent">

    <ListView
        android:id="@+id/list_view"
        android:layout_width="match_parent"
        android:layout_height="match_parent" />

</LinearLayout>
```

修改`MainActivity`类的代码：

```java
public class MainActivity extends AppCompatActivity {

    private String[] data = {"Apple", "banana", "Orange", "Watermelon",
        "Pear", "Grape", "Pineapple", "Strawberry", "Cherry", "Mango",
         "Apple", "banana", "Orange", "Watermelon", "Pear", "Grape",
         "Pineapple", "Strawberry", "Cherry", "Mango"};

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        ArrayAdapter<String> adapter = new ArrayAdapter<>(
                MainActivity.this, android.R.layout.simple_list_item_1, data);
        ListView listView = (ListView) findViewById(R.id.list_view);
        listView.setAdapter(adapter);
    }
}

```

其中，由于`ListView`无法直接接受数组中的数据，必须借助**适配器**来完成。`ArrayApdater`是一个很好的适配器，可以通过泛型来指定要适配的数据类型，然后再构造函数中把要适配的数据传入。

`ArrayApdater`的构造函数依次传入当前上下文、`ListView`子项布局的id（即`LIstView`内部布局的样式的id）、适配的数据。

最后需要调用`ListView`的`setApdater`方法，将适配器对象传递进去。

#### 3.5.2	定制`ListView`界面

...

#### 3.5.4	`LIstView`的点击事件

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1570545571333.png" alt="1570545571333" style="zoom: 50%;" />



### 3.6	更强大的滚动控件——`Recyclerview`

****

解决`RecyclerView`无法使用的问题：

由于官方推荐使用AndroidX，对于较旧的版本的RecyclerView，AndroidX并不支持

首先更改`builed.gradle`：

![1570632653999](C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1570632653999.png)

修改相应的xml文件，写全称：

![1570632819000](C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1570632819000.png)



滚动效果：

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1570633200570.png" alt="1570633200570" style="zoom:80%;" />

改变滚动方向：

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1570633481213.png" alt="1570633481213" style="zoom:80%;" />

主要修改单个Item的xml布局文件、Activity中的layoutManager的方向



<img src="F:\GifResource\RecyclerView.gif" alt="RecyclerView" style="zoom: 67%;" />

### 3.7	最佳实践

****



#### 3.7.1	制作Nine-Patch图片	

![1570681862452](C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1570681862452.png)

注意：

![1570690500343](C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1570690500343.png)

制作完成后删除原来的图片，否则会导致文件重复，项目内无法引用正确的文件。



聊天界面效果：

<img src="F:\GifResource\Message.gif" alt="Message" style="zoom:67%;" />



## 4	手机平板兼顾——探究碎片

****

### 4.1	碎片

碎片（Fragment）时一种可以嵌入在活动中的UI片段。

### 4.2	碎片使用方式

#### 4.2.1	碎片的简单用法

注意：系统内置的`Fragment`只支持Android4.2及之后的系统，在4.2系统之前的设备上运行就会崩溃。

解决办法：

1）将支持版本设为更高版本

2）使用库`support-v4`，在`AndroidX`中好像移除了`android.support.v4.app.fragment`，因此建议使用更高版本的`api`

注意在添加碎片时要添加指明要添加的碎片类名：

例如`activity_main.xml`中：

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout
    xmlns:android="http://schemas.android.com/apk/res/android"
    android:orientation="horizontal"
    android:layout_width="match_parent"
    android:layout_height="match_parent">

    <fragment
        android:id="@+id/left_fragment"
        android:layout_width="0dp"
        android:layout_height="match_parent"
        android:layout_weight="1"
        android:name="com.wujianeng.fragmenttest.LeftFragment"
        />
    <fragment
        android:id="@+id/right_fragment"
        android:layout_width="0dp"
        android:layout_height="match_parent"
        android:layout_weight="1"
        android:name="com.wujianeng.fragmenttest.RightFragment"
        />

</LinearLayout>
```







## 6	数据存储——持久化技术

****

### 6.1	持久化技术简介

Android数据持久化技术主要包含：

1）	文件存储

2）	SharedPreference存储

3）	数据库存储



### 6.2	文件存储

#### 6.2.1	将数据存储在文件中

`Context`类中`openFileOutput`方法，可以用于将数据存储到指定的文件中。

该方法接收两个参数：

1）	文件名。该文件名不能包含路径，默认存储在/data/data/<package name>/files/目录下。

2）	文件的操作模式。主要分为：`MODE_PRIVATE`、`MODE_APPEND`，分别为覆盖模式和追加内容模式。

`openFileOutput`方法返回`FileOutputStream`类的对象，得到对象后可以使用Java流的方式将数据写入到文件中：



文件的写入方法：

1）	调用`openFileOutput`方法，返回`FileOutputStream`类对象

2）	通过`FileOutputStream`类对象，构造`OutputStreamWriter`类对象

3）	通过`OutputStreamWriter`类对象，构造`BufferedWriter`类对象

4）	通过`BufferedWriter`类对象的`writer`方法，将数据写到文件中

```java
String data = "Hello";
try{
    FileOutputStream out = openFileOutput("data");
    BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(out));
    writer.write(data);
}catch(IOException e){
    e.printStackTrace();
}finally{
    if(writer != null){
        writer.close();		//关闭输出缓冲区
    }catch(IOException e){
        e.printStackTrace();
    }
}
```



<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1570695933073.png" alt="1570695933073" style="zoom:80%;" />

#### 6.2.2	从文件中读取数据

1）	利用`openFileInput()`方法返回`FileInputStream`对象

2）	利用`FileInputSteream`对象构造`InputStreamReader`对象

3）	利用`InputStreamReader`对象构造`BufferedReader`对象

4）	利用`BufferedReader`对象调用`readLine()`等方法读取数据

5)	可以利用`StringBuilder`类对象存储读取的字符串，最后使用`toString`方法转化为`String`基本类型。

```java

try{
    FileInputStream in = openFileInput("data");
	BufferedReader reader = new BufferedReader(new InputSreamReader(in));
	String line = "";
	StringBuilder content = new StringBuilder();
	while(((line = reader.readLine()) != null)){
    	content.append(line);
	}
}catch(IOException e){
    e.printStackTrace();
}finally{
    if(reader != null){
        reader.close();		//关闭输入缓冲区
    }catch(IOException e){
        e.printStacktrace();
    }
}


```



### 6.3	`SharedPreferences`存储

****

`SharedPreferences`使用键值对来存储对象

#### 6.3.1	将数据存储到`SharedPreferences`中

获取`SharedPreferences`对象的三种方法：

1）	`Context`类中的`getSharedPreferences()`方法

```java
SharedPreferences.Editor editor =
                        getSharedPreferences("data", MODE_PRIVATE).edit();
editor.putString("name", "Tome");
editor.putString("Sex", "M");
editor.putInt("age", 18);
editor.putBoolean("married", false);
editor.apply();
```

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1570700797376.png" alt="1570700797376" style="zoom:67%;" />





## 9	使用网络技术

****

### 9.2 使用HTTP协议访问网络

#### 9.2.1	使用HttpURLConnection

1）根据链接地址创建URL类对象

`URL address = new URL("https://baidu.com")`

注意：网址不要打错，否则后续都不知道怎么出错的

2）调用`URL`对象的`openConnection()`方法，转换为`HttpURLConnection`类对象

`HttpUrlConnection connection = (HttpURLConnection) url.openConnection()`

3）设置`HttpURlConnection`对象所使用`Http`请求的方法`GET`获取`POST`发送，以及相应的连接超时、读取超时等

```java
connection.setRequestMethod("POST");
connection.setConnectionTimeOut(8000);//连接超时为8000ms
connection.setReadTimeOut(8000);//读取超时为8000ms
```

4）根据`HttpURLConnection`对象的`getInputStream()`方法返回`InputStream`类对象

`InputStream in = connection.getInputStream()`

5）关闭连

`connection.disconnect()`

注意：上述流程应当进行异常处理

#### 9.2.2 使用`OkHttp`

项目地址：`https://github.com/square/okhttp`

1）添加依赖

在使用时需要添加相关依赖（开源库）

`com.squareup.okhttp3:okhttp:3.4.1"

2）新建`OkHttpClient`对象

`OkHttpClient client = new OkHttpClient()`

3）若发送数据，则先创建一个`Request`类对象

`Request request = new Request.Builder().URL("http://www.baidu.com").build()`

4）调用OkHttpClient的newCall()方法来创建一个Call对象，并调用它的excute()方法来发送请求，并返回一个Response类对象（其中包含服务器的返回数据）

```java
Response response = client.newCall(request).excute();
```

5）解析数据

```java
String responseData = response.body().string();
```

如过是发送数据给服务器（POST），则需要先构建一个RequestBody对象来存放提交的参数

```java
RequestBody requestBody = new FormBody.Builder()
    .add("username", "wujianeng")
    .add("password", "123456")
    .build();
//调用Request的方法
Request request = new Request.Builder()
    .url("http://baidu.com")
    .post(requestBody)
    .builde();
//调用OkHttpClient的newCall生成Call对象，调用Call对象的excute()方法向服务器发送数据并获取服务器返回的数据
Response response = client.newCall(request).exxcute();
```



## 14	实战——开发`CoolApp97`

****

### 14.0	写在前面

在开发中遇到的一些坑，都写在这里：

#### 14.0.1	程序崩溃

在按照书上步骤做到显示省市县级别数据时，开始调试程序。程序一开启就发生了崩溃，不知道错误原因。后来通过不断地查找，发现是在碎片的使用方式那一节（我还没看）中提到过，对于4.2之前的版本，最好不要使用系统内置的`android.app.Fragment`，而是应该使用`android.support.v4.app.Fragment`。

也就是说，系统崩溃有可能是虚拟机Android系统版本太低与新的系统库不兼容导致的。

因此解决办法既可以是使用兼容的库，也可以更换新的虚拟机。4.3的版本已经很老了，可以更换更新的版本，我本次更换的是7.0版本。因为我的手机(魅蓝s6，19年10月份应该算是渣渣手机了)使用的正是7.0，相信应该绝大多数人使用的版本都比我高。

#### 14.0.2	无法获取县级数据

调试流程

1)	确认服务器可以正常返回数据

2）	通过设置输出点判断程序是在哪一步出错

通过Toast.makText(...)方法发现我的Http请求中address少一个"/"。。。

打字得注意，同时要**会调试！！！！**

#### 14.0.3	和风天气API发生变化

我申请的key=`1a6519465cdd463c87c9e1fd7511afc3`

其webAPI为：

```java
https://free-api.heweather.net/s6/weather/{weather-type}?{parameters}
```

![1570779887361](C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1570779887361.png)

![1570779905834](C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1570779905834.png)

![1570779912019](C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1570779912019.png)



返回的格式为：

```json
{
    "HeWeather6":[
        {
            "status":"ok"
            "basic":{
            	"cid":"CN101200511"
            	"location":" 黄州"
            	...
                 "lat":"30.44743538"
                 "lon":"114.87893677"
                 "tz":"+8:00"
        	}
        	"update"={
        		"loc";"2019-10-11 14:57"
        		"utc":"2019-10-11 06:57"
        	}
			"now":{
				"cloud":"99"
                  "cloud_code":"104"
                  "cond_txt":"阴"
                  "fl":"21"
                  "pcpn":
                  "pres":
                  "tmp":
                  "vis":
                  "wind_deg":
                  "wind_dir":
                  "wind_sc":
                  "wind_spd":
             }
			"daily_forecast":[]//3
			"lifestyle":[] //各种建议
        }
    ]
}
```





![1570781046614](C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1570781046614.png)



![1570781061466](C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1570781061466.png)

![1570781079585](C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1570781079585.png)

![1570781092552](C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1570781092552.png)

![1570781108129](C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1570781108129.png)

![1570781131950](C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1570781131950.png)

![1570781160539](C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1570781160539.png)

![1570781173926](C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1570781173926.png)

这些数据需要分为多次请求才能全部得到，分别查询`now`、`forecast`、`lifestyle`，`hourly`好像没有权限访问

请求`hourly`会出现`permission denied`

### 14.1	功能需求

1）	选择省市县

2）	查看任意城市的天气

3）	自由切换城市

4）	可以手动更新和自动更新



14.2	`github`

已上传github，本地在AndroidLearning文件夹内



14.3	创建数据库和表

<img src="F:\GifResource\District.gif" alt="District" style="zoom:80%;" />