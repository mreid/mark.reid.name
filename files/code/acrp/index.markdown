---
layout: name
section: Code
title: ACRP Database Visualisation
---

Visualising 19th Century Australian Readerships
===============================================

The application below will start automatically after it has finished loading.

<div id="vis_container" style="margin: 0 0 0 -57px;">

<!--[if !IE]> -->
	<object classid="java:vis.class" 
			type="application/x-java-applet"
			archive="vis.jar,controlP5.jar,opencsv.jar,opencsv.jar,core.jar"
			width="750" height="550"
			standby="Loading Processing software..." >
			
		<param name="archive" value="vis.jar,controlP5.jar,opencsv.jar,opencsv.jar,core.jar" />
	
		<param name="mayscript" value="true" />
		<param name="scriptable" value="true" />
	
		<param name="image" value="loading.gif" />
		<param name="boxmessage" value="Loading Processing software..." />
		<param name="boxbgcolor" value="#FFFFFF" />
	
		<param name="test_string" value="outer" />
<!--<![endif]-->
	
	<object classid="clsid:8AD9C840-044E-11D1-B3E9-00805F499D93" 
			codebase="http://java.sun.com/update/1.5.0/jinstall-1_5_0_15-windows-i586.cab"
			width="750" height="550"
			standby="Loading Processing software..."  >
			
		<param name="code" value="vis" />
		<param name="archive" value="vis.jar,controlP5.jar,opencsv.jar,opencsv.jar,core.jar" />
		
		<param name="mayscript" value="true" />
		<param name="scriptable" value="true" />
		
		<param name="image" value="loading.gif" />
		<param name="boxmessage" value="Loading Processing software..." />
		<param name="boxbgcolor" value="#FFFFFF" />
		
		<param name="test_string" value="inner" />
		
		<p>
			<strong>
				This browser does not have a Java Plug-in.
				<br />
				<a href="http://java.sun.com/products/plugin/downloads/index.html" title="Download Java Plug-in">
					Get the latest Java Plug-in here.
				</a>
			</strong>
		</p>
	
	</object>
	
<!--[if !IE]> -->
	</object>
<!--<![endif]-->

</div>

Brief instructions (see [paper](/code/acrp/) for full details):
* Each point represents a book. Its size and redness indicates its number of borrowers. Details are shown in the bottom left.
* The "Choose Libraries" list at the top restricts the display to books from a specific library.
* The "Borrowers" bar at the bottom right controls how many borrowers a book must have in order to be shown.
* Click on a point to select it. Lines will appear indicating books with common borrowers.
* The "Similarity" bar in the bottom right controls what proportion of overlapping borrowers is required for a connecting line.
* Typing in the "Title" and "Author" fields at the bottom will restrict the view to matching books.
* Clicking in an empty space and dragging will draw a region to zoom into. Right-clicking will reset the view after a zoom.
