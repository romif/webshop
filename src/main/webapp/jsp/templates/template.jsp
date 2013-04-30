<%@ taglib uri="http://www.eckelobjects.com/tagtut/tags1.0" prefix='template' %>
<html>
	<head>
		<template:get name='head'/>
	</head>
	
	<body onLoad="hideLoading();" >
		<div id="main">
			<div id="preload" style="z-index:999"><img src="${pageContext.request.contextPath}/pics/ajax-loader.gif"/></div>
			<div id="header">
				<template:get name='header'/>
			</div>
			<div id="topMenu">
				<template:get name='topMenu'/>
			</div>
			<div id="rightcolbg">
				<div id="leftcolbg">
					<div id="wrapper">
						<div class="content">
							<div id="centerColumn">
								<template:get name='centerColumn'/>
								<br>
							</div>
						</div>
						<div id="leftColumn">
							<template:get name='leftColumn'/>
						</div>
						<iframe id="fcompare" name="fcompare" src="./TopmoBail_files/saved_resource.htm" scrolling="no" frameborder="0" style="position: absolute; left: -1000px; top: -1000px; z-index: 100; background-color: #FFF;"></iframe>
						<div id="rightColumn">
							<template:get name='rightColumn'/>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div id="footer">
			<template:get name='footer'/>
		</div>
		
		<!-- <script type="text/javascript">
			var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
			document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
		</script>
		<script src="./TopmoBail_files/ga.js" type="text/javascript"></script>
		<script type="text/javascript">
			try {
				var pageTracker = _gat._getTracker("UA-240222-23");
				pageTracker._trackPageview();
			} 
			catch(err) {}
		</script> -->
		
	</body>
</html>