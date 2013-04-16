// Авторы: Буравлев А.С. / Матвеев И.В. 
// Код реализующий функции "плавающего" окна
// код для MSIE4 и выше

DHTMLcart.checkonscroll=function()
{
    for (var i = 1; i <= document.numObj; i++)
    {
		obj = document.all[document.objArray[i]].DHTMLcart;

		diffY = document.body.scrollTop;
		diffX = document.body.scrollLeft;
		curX  = obj.rootDocHead.style.pixelLeft;
		curY  = obj.rootDocHead.style.pixelTop;

		targetX = obj.left + diffX;
		targetY = obj.top  + diffY;

		if (curX != targetX)
    	{
    		curHorShift = (targetX - curX);
	        curHorShift = (curHorShift > 0) ? Math.ceil(curHorShift):Math.floor(curHorShift);

			obj.rootDocHead.style.pixelLeft += curHorShift;
    	    obj.rootDocObj.style.pixelLeft  += curHorShift;
		}

		if (curY != targetY)
    	{
	    	curVertShift = (targetY - curY);
    	    curVertShift = (curVertShift > 0) ? Math.ceil(curVertShift):Math.floor(curVertShift);

			obj.rootDocHead.style.pixelTop += curVertShift;
    	    obj.rootDocObj.style.pixelTop  += curVertShift;
		}
    }
}

// мышь над заголовком объекта
function DHTMLcartOnMouseOver()
{
    var obj                 = this.DHTMLcart;
    window.draggedDHTMLcart = obj;    
    obj.oldonmousedown      = document.onmousedown;
    window.onmousedown      = DHTMLcartDrag;

    window.captureEvents(Event.MOUSEDOWN);
    return false;
}

// мышь съехала с заголовка объекта
function DHTMLcartOnMouseOut()
{
    var obj                 = this.DHTMLcart;
    window.draggedDHTMLcart = null;   
    window.onmousedown      = obj.oldonmousedown;

    window.releaseEvents(Event.MOUSEDOWN);

    return false;
}

function DHTMLcartMove(e)
{
    var obj = document.draggedDHTMLcart;
    var curX;
    var curY;

	if(event.button == 0)
    {
    	DHTMLcartDrop();                        
        return true;
	}

    curX     = event.clientX - obj.dragXOffset;
    curY     = event.clientY - obj.dragYOffset
    obj.left = curX;
    obj.top  = curY;

	obj.rootDocObj.style.visibility = "hidden";

	obj.rootDocHead.style.pixelLeft = curX + document.body.scrollLeft;
    obj.rootDocHead.style.pixelTop  = curY + document.body.scrollTop;
    obj.rootDocObj.style.pixelLeft  = curX + document.body.scrollLeft;
    obj.rootDocObj.style.pixelTop   = curY + obj.headerHeight + document.body.scrollTop;

	event.returnValue = false;      
    return false;
}

function DHTMLcartDrop()
{       
    var obj = document.draggedDHTMLcart;

	obj.rootDocObj.style.visibility = "visible";

	document.onmousemove = obj.oldonmousemove;
    document.onmouseup   = obj.oldonmouseup;            

    document.draggedDHTMLcart = null;
    return true;               
}

function DHTMLcartDrag(e)
{
    var obj;

	obj = this.DHTMLcart;

	obj.dragXOffset = event.clientX - obj.left;
    obj.dragYOffset = event.clientY - obj.top;  

	obj.oldonmousemove = document.onmousemove;
    obj.oldonmouseup   = document.onmouseup;

	document.onmousemove = DHTMLcartMove;
    document.onmouseup   = DHTMLcartDrop;

    document.draggedDHTMLcart = obj;  
    return true;
}

// Функция, сохраняющая статические координаты объекта
function DHTMLcartHoldPosition(objname)
{
    var diffX, diffY, targetX, targetY, curHorShift, curVertShift, curX, curY, obj;
    var percent = 0.1;

    if(document.draggedDHTMLcart != null)
    {
       	this.holdFunc = setTimeout("DHTMLcartHoldPosition('"+objname+"')", 1);
        return false;
    }
  
	obj = document.all[objname].DHTMLcart;

	if (obj.rootDocObj.style.pixelWidth != obj.width)
    {
    	obj.rootDocObj.style.pixelWidth  = obj.width;
        obj.rootDocHead.style.pixelWidth = obj.width;
	}
    if (obj.rootDocObj.style.pixelHeight != obj.height)
    {
    	obj.rootDocObj.style.pixelHeight  = obj.height;
        obj.rootDocHead.style.pixelHeight = obj.height;
	}
	if (obj.srcChanged) 
	{
    	obj.srcChanged     = false;
		obj.rootDocObj.src = obj.src;
	}     
        
	diffY = document.body.scrollTop;
    diffX = document.body.scrollLeft;

	curX  = obj.rootDocHead.style.pixelLeft;
    curY  = obj.rootDocHead.style.pixelTop;

	targetX = obj.left + diffX;
    targetY = obj.top  + diffY;

	if (curX != targetX)
    {
    	curHorShift = (targetX - curX);
        curHorShift = (curHorShift > 0) ? Math.ceil(curHorShift):Math.floor(curHorShift);

		obj.rootDocHead.style.pixelLeft += curHorShift;
        obj.rootDocObj.style.pixelLeft  += curHorShift;
	}

	if (curY != targetY)
    {
    	curVertShift = (targetY - curY);
        curVertShift = (curVertShift > 0) ? Math.ceil(curVertShift):Math.floor(curVertShift);

		obj.rootDocHead.style.pixelTop += curVertShift;
        obj.rootDocObj.style.pixelTop  += curVertShift;
	}
}

// Параметры по умолчанию
DHTMLcart.id           = "DHTMLcartObj"; // идентификатор объекта
DHTMLcart.visible      = false;           // видимость
DHTMLcart.left         = 0;              // x-координата левого верхнего угла
DHTMLcart.top          = 0;              // y-координата левого верхнего угла
DHTMLcart.width        = 100;             // ширина
DHTMLcart.height       = 100;             // высота
DHTMLcart.headerHeight = 15;             // высота заголовка
DHTMLcart.headerHTML   = "None";
DHTMLcart.src          = "/shcart/?step=0";    // документ отображаемый в элементе
DHTMLcart.scroll       = false;
DHTMLcart.scrolling    = "no";
DHTMLcart.addmsieparam = "";
DHTMLcart.addmsiestyle = "";
  
// Установка координаты Х
function DHTMLcartSetLeft(left)
{
	left = parseInt(left);
	if(this.left != left)
		this.left = left;

	this.holdFunc = setTimeout("DHTMLcartHoldPosition('"+this.id+"')", 1);
};

// Установка координаты Y
function DHTMLcartSetTop(top)
{
	top = parseInt(top);
	if(this.top != top)
    	this.top = top;

	this.holdFunc = setTimeout("DHTMLcartHoldPosition('"+this.id+"')", 1);
};

// Установка ширины
function DHTMLcartSetWidth(width)
{
	width = parseInt(width);
    if (this.width != width)
    	this.width = width;

	this.holdFunc = setTimeout("DHTMLcartHoldPosition('"+this.id+"')", 1);
};

// Установка высоты
function DHTMLcartSetHeight(height)
{
	height = parseInt(height);
    if (this.height != height)
	    this.height = height;

	this.holdFunc = setTimeout("DHTMLcartHoldPosition('"+this.id+"')", 1);
};

// Замена документа, содержащегося в DHTMLcart
function DHTMLcartSetSrc(src)
{
    if(this.src != src)
    {
        this.srcChanged = true;
        this.src        = src;
    }

	this.holdFunc = setTimeout("DHTMLcartHoldPosition('"+this.id+"')", 1);

    return true;
};

// Изменение видимости
function DHTMLcartSetVisibility(vis)
{
    if(vis)
    {
        this.visible = true;
		this.rootDocObj.style.visibility  = "visible";
        this.rootDocHead.style.visibility = "visible";
    }
    else
    {
        this.visible = false;
     	this.rootDocObj.style.visibility  = "hidden";
        this.rootDocHead.style.visibility = "hidden";
    }
};

//конструктор
function DHTMLcart(definition)
{
    var HTMLstr;

    this.id = DHTMLcart.id;
    if(definition)
    {
        this.id           = (definition.id)           ? definition.id           : DHTMLcart.id;
        this.visible      =  definition.visible;
        this.left         = (definition.left)         ? definition.left         : DHTMLcart.left;
        this.top          = (definition.top)          ? definition.top          : DHTMLcart.top;
        this.width        = (definition.width)        ? definition.width        : DHTMLcart.width;
        this.height       = (definition.height)       ? definition.height       : DHTMLcart.height;
        this.src          = (definition.src)          ? definition.src          : DHTMLcart.src;         
        this.headerHeight = (definition.headerHeight) ? definition.headerHeight : DHTMLcart.headerHeight;             
        this.headerHTML   = (definition.headerHTML)   ? definition.headerHTML   : DHTMLcart.headerHTML;             
        this.scrolling    = (definition.scrolling)    ? definition.scrolling    : DHTMLcart.scrolling;             
        this.addmsieparam = (definition.addmsieparam) ? definition.addmsieparam : DHTMLcart.addmsieparam;
        this.addmsiestyle = (definition.addmsiestyle) ? definition.addmsiestyle : DHTMLcart.addmsiestyle;
    }
    else
    {
        this.id           = DHTMLcart.id;
        this.visible      = DHTMLcart.visible;
        this.left         = DHTMLcart.left;
        this.top          = DHTMLcart.top;
        this.width        = DHTMLcart.width;
        this.height       = DHTMLcart.height;
        this.src          = DHTMLcart.src;         
        this.headerHeight = DHTMLcart.headerHeight;               
        this.headerHTML   = DHTMLcart.headerHTML;
        this.scrolling    = DHTMLcart.scrolling;
        this.addmsieparam = DHTMLcart.addmsieparam;
        this.addmsiestyle = DHTMLcart.addmsiestyle;
    }

	HTMLstr =  '<DIV  ID="'+this.id+'_header"  CLASS="dhtmlCartHead" STYLE="position:absolute;overflow:clip;z-index:10;';
    HTMLstr += 'left:'+this.left+';top:'+this.top+';';
    HTMLstr += 'height:'+this.headerHeight + ';width:'+this.width+';'

	if(this.visible) 
    	HTMLstr += 'visibility:show;">';
	else
    	HTMLstr += 'visibility:hidden;">';

	HTMLstr += this.headerHTML;
    HTMLstr += '</DIV>\n';
    HTMLstr += '<IFRAME ID="' +this.id + '"  SRC="' +this.src + '" '+ this.addmsieparam + ' ';
    HTMLstr += 'HEIGHT="' + (this.height-this.headerHeight) + '" WIDTH="'+this.width+'" SCROLLING="' + this.scrolling + '" ';
    HTMLstr += 'STYLE="position:absolute;'+ this.addmsiestyle + ' left:'+this.left+';top:'+(this.top+this.headerHeight)+';height:'+(this.height-this.headerHeight)+'; width:'+this.width+';'+'z-index:400; border: none;';

	if(this.visible) 
    	HTMLstr += 'visibility:show;">';
	else
    	HTMLstr += 'visibility:hidden;">';
	HTMLstr+='</IFRAME>\n';

    document.write(HTMLstr);
    document.draggedDHTMLcart = null;

	this.rootDocObj   = document.all[this.id];
    this.rootDocFrame = document.frames[this.id];
    this.rootDocHead  = document.all[this.id+'_header'];

	this.rootDocHead.onmousedown = DHTMLcartDrag;

    this.rootDocHead.DHTMLcart = this;
    this.rootDocObj.DHTMLcart  = this;
    this.setLeft               = DHTMLcartSetLeft;
    this.setTop                = DHTMLcartSetTop;
    this.setWidth              = DHTMLcartSetWidth;
    this.setHeight             = DHTMLcartSetHeight;
    this.setSrc                = DHTMLcartSetSrc;
    this.setVisibility         = DHTMLcartSetVisibility;      

	if (definition.scroll)
    {
    	if (typeof document.objArray == 'undefined' || document.objArray == null)
        {
        	document.objArray = new Array();
            document.numObj   = 0;
		}
        document.numObj += 1;
        document.objArray[document.numObj] = this.id;

	    window.onscroll = DHTMLcart.checkonscroll;
	}

    return this;
}


document.write('<STYLE  TYPE="text/css">');
document.write(' .dhtmlCartHead {cursor:pointer;}');
document.write('</STYLE>');

