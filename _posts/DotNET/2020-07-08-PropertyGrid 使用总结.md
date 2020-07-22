---
layout: post
category: .NET
title: PropertyGrid 中只显示部分属性
tagline: by 明不知昔
tags: 
  - .NET
  - C#
published: true
---

最近用到了PropertyGrid，原来从来没用到过，拿在手里，一头雾水，经过一段时间研究后，大概理解了Property的使用方法，下面仔细剖析一下。

PropertyGrid控件就是Visual Studio开发工具里面的属性浏览器，我们在VS里面可以通过属性浏览器查看，修改控件的属性，并主要通过使用反射来检索项目的属性。

<!--more-->

## 普通显示

在PropertyGrid中显示属性很容易，我们可以直接给propertyGrid1.SelectedObject 属性赋值，SelectObject属性可以获取或设置当前选定的对象，数据类型为object,这就意味着我们可以直接将一个对象赋给它。针对一个对象，它会将对象中的所有公共属性显示在PropertyGrid上。

如果要同时显示多个对象，可以将一个对象数组赋值给 propertyGrid1.SelectedObjects。它会自动计算多个对象的公开属性并显示，当各个对象中属性值相同时，会显示相同的值，如果不同时，则会不显示确定的值。



## 更改显示方式

当只用上面的赋值方式，那么显示出来的数据名称会直接是属性的名称，如果想要进行汉化，需要对每个属性添加相应的特性（Attribute）来进行配置。

特性是用于为类型、字段、方法和属性等编程元素添加批注的声明标记，在运行时可以使用反射对其进行检索。下面列出了在 PropertyGrid 中用到的特性：

- DescriptionAttribute

  设置显示在属性下方说明帮助窗格中的属性文本。这是一种为活动属性（即具有焦点的属性）提供帮助文本的有效方法。

- CategoryAttribute

  设置属性在网格中所属的类别。当您需要将属性按类别名称分组时，此特性非常有用。如果没有为属性指定类别，该属性将被分配给 "杂项" 类别。可以将此特性应用于所有属性。

- BrowsableAttribute 

  表示是否在网格中显示属性。此特性可用于在网格中隐藏属性。默认情况下，公共属性始终显示在网格中。

- ReadOnlyAttribute

  表示属性是否为只读。此特性可用于禁止在网格中编辑属性。默认情况下，带有 get 和 set 访问函数的公共属性在网格中是可以编辑的，如果只有 get 访问器的公共属性也是只读的。

- DefaultValueAttribute

  表示属性的默认值。如果希望为属性提供默认值，然后确定该属性值是否与默认值相同，则可使用此特性。可以将此特性应用于所有属性。

- DefaultPropertyAttribute

  表示类的默认属性。在网格中选择某个类时，将首先突出显示该类的默认属性。



> 如果想要在属性表中添加颜色选择和字体选择那是很容易一件事，可以在要展示的类中添加Color类型属性，和Font类型属性，绑定后，就可以进行颜色选择和字体选择了



## 自定义显示

我们可以看出这种上面这种显示属性方法并不够灵活，我们不能方便的及时增加或者删除属性。

```C#
//属性表管理类
public class PropertyManageCls : CollectionBase, ICustomTypeDescriptor
{
    public void Add(Property value)
    {
        int flag=-1;
        if (value != null)
        {
            if (base.List.Count>0)
            {
                IList <Property> mList=new List<Property>();
                for (int i = 0; i < base.List.Count; i++)
                {
                    Property p = base.List[i] as Property;
                    if (value.Name == p.Name)
                    {
                        flag = i;
                    }
                    mList.Add(p);
                }
                if (flag == -1)
                {
                    mList.Add(value);
                }
                base.List.Clear();
                foreach (Property p in mList)
                {
                    base.List.Add(p);
                }
            }
            else
            {
                base.List.Add(value);
            }
        }
    }
    public void Remove(Property value)
    {
        if(value!=null&&base.List.Count>0)
        base.List.Remove(value);
    }
    public Property this[int index]
    {
        get
        {
            return (Property)base.List[index];
        }
        set
        {
            base.List[index] = (Property)value;
        }
    }
    #region ICustomTypeDescriptor 成员
    public AttributeCollection GetAttributes()
    {
        return TypeDescriptor.GetAttributes(this,true);
    }
    public string GetClassName()
    {
        return TypeDescriptor.GetClassName(this, true);
    }
    public string GetComponentName()
    {
        return TypeDescriptor.GetComponentName(this, true);
    }
    public TypeConverter GetConverter()
    {
        return TypeDescriptor.GetConverter(this, true);
    }
    public EventDescriptor GetDefaultEvent()
    {
        return TypeDescriptor.GetDefaultEvent(this, true);
    }
    public PropertyDescriptor GetDefaultProperty()
    {
        return TypeDescriptor.GetDefaultProperty(this, true);
    }
    public object GetEditor(Type editorBaseType)
    {
        return TypeDescriptor.GetEditor(this, editorBaseType, true);
    }
    public EventDescriptorCollection GetEvents(Attribute[] attributes)
    {
        return TypeDescriptor.GetEvents(this, attributes, true);
    }
    public EventDescriptorCollection GetEvents()
    {
        return TypeDescriptor.GetEvents(this,true);
    }
    public PropertyDescriptorCollection GetProperties(Attribute[] attributes)
    {
        PropertyDescriptor[] newProps = new PropertyDescriptor[this.Count];
        for (int i = 0; i < this.Count; i++)
        {
            Property prop = (Property)this[i];
            newProps[i] = new CustomPropertyDescriptor(ref prop, attributes);
        }
        return new PropertyDescriptorCollection(newProps);
    }
    public PropertyDescriptorCollection GetProperties()
    {
        return TypeDescriptor.GetProperties(this, true);
    }
    public object GetPropertyOwner(PropertyDescriptor pd)
    {
        return this;        
    }
    #endregion
}


//属性类
public class Property
{
    private string _name=string.Empty;
    private object _value=null;
    private bool _readonly=false;
    private bool _visible=true;
    private string _category=string.Empty;
    TypeConverter _converter=null;
    object _editor = null;
    private string _displayname = string.Empty;
    public Property(string sName, object sValue)
    {
        this._name = sName;
        this._value = sValue;
    }
    public Property(string sName, object sValue, bool sReadonly, bool sVisible)
    {
        this._name = sName;
        this._value = sValue;
        this._readonly = sReadonly;
        this._visible = sVisible;
    }
    public string Name  //获得属性名
    {
        get
        {
            return _name;
        }
        set
        {
            _name=value;
        }
    }
    public string DisplayName   //属性显示名称
    {
        get
        {
            return _displayname;
        }
        set
        {
            _displayname = value;
        }
    }
    public TypeConverter Converter  //类型转换器，我们在制作下拉列表时需要用到
    {
        get 
        {
            return _converter;
        }
        set
        {
            _converter = value;
        }
    }
    public string Category  //属性所属类别
    {
        get
        {
            return _category;
        }
        set
        {
            _category = value;
        }
    }
    public object Value  //属性值
    {
        get
        {
            return _value;
        }
        set
        {
            _value=value;
        }
    }
    public bool ReadOnly  //是否为只读属性
    {
        get
        {
            return _readonly;
        }
        set
        {
            _readonly = value;
        }
    }
    public bool Visible  //是否可见
    {
        get
        {
            return _visible;
        }
        set
        {
            _visible = value;
        }
    }
    public virtual object Editor   //属性编辑器
    {
        get 
        { 
            return _editor; 
        }
        set 
        { 
            _editor = value; 
        }
    }
}


public class CustomPropertyDescriptor : PropertyDescriptor
{
    Property m_Property;
    public CustomPropertyDescriptor(ref Property myProperty, Attribute[] attrs)
        : base(myProperty.Name, attrs)
    {
        m_Property = myProperty;
    }
    #region PropertyDescriptor 重写方法
    public override bool CanResetValue(object component)
    {
        return false;
    }
    public override Type ComponentType
    {
        get
        {
            return null;
        }
    }
    public override object GetValue(object component)
    {
        return m_Property.Value;
    }
    public override string Description
    {
        get
        {
            return m_Property.Name;
        }
    }
    public override string Category
    {
        get
        {
            return m_Property.Category;
        }
    }
    public override string DisplayName
    {
        get
        {
            return m_Property.DisplayName!=""?m_Property.DisplayName:m_Property.Name;
        }
    }
    public override bool IsReadOnly
    {
        get
        {
            return m_Property.ReadOnly;
        }
    }
    public override void ResetValue(object component)
    {
        //Have to implement
    }
    public override bool ShouldSerializeValue(object component)
    {
        return false;
    }
    public override void SetValue(object component, object value)
    {
        m_Property.Value = value;
    }
    public override TypeConverter Converter
    {
        get
        {
            return m_Property.Converter;
        }
    }
    public override Type PropertyType
    {
        get { return m_Property.Value.GetType(); }
    }
    public override object GetEditor(Type editorBaseType)
    {
        return m_Property.Editor==null? base.GetEditor(editorBaseType):m_Property.Editor;
    }
    #endregion
}
```

下面我们来看看该如何使用，我们仍然在Form_load中添加代码如下：

``` c#
PropertyManageCls pmc = new PropertyManageCls();
Property pp = new Property("ID", "1", false, true);
pp.Category = "基本信息";
pp.DisplayName = "我的ID";
pmc.Add(pp);
propertyGrid1.SelectObject=pmc;
```

显示结果：

![](https://i.loli.net/2020/07/21/hnxj6gibBDWHytu.png)



## 实现下拉框

要实现下拉框，需要使用类型转换器，继承与TypeConverter或者StringConverter，然后重写方法，代码如下：

``` C#
//下拉框类型转换器
public class DropDownListConverter : StringConverter
{
    object[] m_Objects;
    public DropDownListConverter(object[] objects)
    {
        m_Objects = objects;
    }
    public override bool GetStandardValuesSupported(ITypeDescriptorContext context)
    {
        return true;
    }
    public override bool GetStandardValuesExclusive(ITypeDescriptorContext context)
    {
        return true;//true下拉框不可编辑
    }
    public override
    System.ComponentModel.TypeConverter.StandardValuesCollection GetStandardValues(ITypeDescriptorContext context)
    {
        //我们可以直接在内部定义一个数组，但并不建议这样做，这样对于下拉框的灵活性有很大影响
        return new StandardValuesCollection(m_Objects);
        
        // 此处一般是根据 context 中传递下来的 Instance，从中获取下拉的条件，动态生成下拉选项        
    }
}
```

我们实现了下拉框类型转换器，但该如何使用呢？

- 方法一：在属性上方添加标记 [TypeConverter(typeof(DropDownListConverter))]

- 方法二：我们可以在外部定义数组，使用方便，使用方法代码如下：

  ``` C#
  private void Form_load(object sender, EventArgs e)
      {
              PropertyManageCls pmc = new PropertyManageCls();
              string []s=new string[] { "1", "2", "3", "4" };
              Property pp = new Property(txtname.Text,txtvalue.Text, false, true);
              pp.Category = "基本信息";
              pp.DisplayName = "我的ID";
              pp.Converter = new DropDownListConverter(s);//Property的Converter属性就可以设置类型转换
              pmc.Add(pp);
              propertyGrid1.SelectObject = pmc;
  }
  ```

效果图如下：

![20200721234055.png](https://i.loli.net/2020/07/21/ipstk1OyB7FGbd9.png)

## 属性编辑器

使用属性编辑器实现路径选择，属性编辑器需要继承与UITypeEditor。

``` C#
//文件路径选择                                                                                                                     public class PropertyGridFileItem : UITypeEditor
{

    public override UITypeEditorEditStyle GetEditStyle(System.ComponentModel.ITypeDescriptorContext context)
    {

        return UITypeEditorEditStyle.Modal;

    }

    public override object EditValue(System.ComponentModel.ITypeDescriptorContext context, System.IServiceProvider provider, object value)
    {

        IWindowsFormsEditorService edSvc =
            (IWindowsFormsEditorService)provider.GetService(typeof(IWindowsFormsEditorService));

        if (edSvc != null)
        {

            // 可以打开任何特定的对话框

            OpenFileDialog dialog = new OpenFileDialog();

            dialog.AddExtension = false;

            if (dialog.ShowDialog().Equals(DialogResult.OK))
            {

                return dialog.FileName;

            }
        }

        return value;

    }

}
```

使用方法：

- 在属性上方添加标记[EditorAttribute(typeof(PropertyGridFileItem), typeof(System.Drawing.Design.UITypeEditor))]

- 使用代码

  ``` C#
  private void Form_load(object sender, EventArgs e)
  {
      PropertyManageCls pmc = new PropertyManageCls();
      Property pp = new Property(txtname.Text,txtvalue.Text, false, true);
      pp.Category = "基本信息";
      pp.DisplayName = "我的ID";
      pp.Editor= new PropertyGridFileItem();//Property的Editor属性就可以设置属性编辑
      pmc.Add(pp);
      propertyGrid1.SelectObject = pmc;
  }
  ```

效果图如下：

![](https://i.loli.net/2020/07/21/NgqsPfShQpMvyTa.png)

## 自定义要显示的属性

PropertyGrid 默认显示所有的公开属性，包括父类的公开属性。在使用的过程中，我们可能会有如下需求：

- 只想显示子类的某些属性，而父类因为某些原因不能将它的属性标记为 [Browsable(false)]
- 想通过自定义的 Attribute 来控制属性的显示

这个时候，我们就需要对显示的属性进行筛选。我们通过实现 ICustomTypeDescriptor，然后重写方法 `public PropertyDescriptorCollection GetProperties(Attribute[] attributes)` 来实现。

实现部分代码如下：

``` C#
public class NamedGroup :ICustomTypeDescriptor
{
    #region ICustomTypeDescriptor
    public AttributeCollection GetAttributes()
    {
        return TypeDescriptor.GetAttributes(this, true);
    }

    public string GetClassName()
    {
        return TypeDescriptor.GetClassName(this, true);
    }

    public string GetComponentName()
    {
        return TypeDescriptor.GetComponentName(this, true);
    }

    public TypeConverter GetConverter()
    {
        return TypeDescriptor.GetConverter(this, true);
    }

    public EventDescriptor GetDefaultEvent()
    {
        return TypeDescriptor.GetDefaultEvent(this, true);
    }

    public PropertyDescriptor GetDefaultProperty()
    {
        return TypeDescriptor.GetDefaultProperty(this, true);
    }

    public object GetEditor(Type editorBaseType)
    {
        return TypeDescriptor.GetEditor(this, editorBaseType, true);
    }

    public EventDescriptorCollection GetEvents()
    {
        return TypeDescriptor.GetEvents(this, true);
    }

    public EventDescriptorCollection GetEvents(Attribute[] attributes)
    {
        return TypeDescriptor.GetEvents(this, attributes, true);
    }

    public object GetPropertyOwner(PropertyDescriptor pd)
    {
        return this;
    }

    // 修改此属性，进行展示
    public PropertyDescriptorCollection GetProperties()
    {
        return TypeDescriptor.GetProperties(this,true);
    }

    public PropertyDescriptorCollection GetProperties(Attribute[] attributes)
    {
        // 特别注意，此处的 true 代表不使用当前类的 GetProperties 方法来获取属性，默认为 false,这会导致无限循环，从而导致栈溢出
        PropertyDescriptorCollection pdc = TypeDescriptor.GetProperties(this, attributes, true);
        PropertyDescriptor[] properties = pdc.Cast<PropertyDescriptor>().Where(item => item.Attributes.Cast<Attribute>().Any(itemA => itemA is BrowsableAttribute ba && ba.Browsable)).ToArray();
        return new PropertyDescriptorCollection(properties);
    }    
    #endregion
}
```



## 致谢

[1]. 本文来源：[C#自定义PropertyGrid属性](https://blog.csdn.net/lxping1012/article/details/7073944)



## 更多参考资料

[1]. [PropertyGrid控件心得](http://blog.csdn.net/luyifeiniu/article/details/5426960#创建 PropertyGrid 控件)

[2]. [Customized display of collection data in a PropertyGrid](http://www.codeproject.com/KB/tabs/customizingcollectiondata.aspx)

[3]. [TypeConverter的层次结构](http://msdn.microsoft.com/en-us/library/8cexyz1e)

[4]. [关于PropertyGrid中属性的值动态从数据库取出](http://topic.csdn.net/u/20100827/11/5524219a-4457-4921-b8f2-b4c63bc6b016.html)

[5]. [动态可订制属性的 PropertyGrid](http://blog.csdn.net/akron/article/details/2750566)