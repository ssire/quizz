Quizz
=====

This is the **Quizz module** shown on the [www.oppidoc.fr/demos/quizz](http://www.oppidoc.fr/demos/quizz) demo

The module shows how to build a simple custom document editor with the [AXEL](https://github.com/ssire/axel) (Adaptable XML Editing Library) javascript library, using XTiger XML document templates.

## How to test this module ?

The module comes with a sample `continent.xml` XML Quizz document. The file `generator.xsl` is an XSLT transformation that generates a quizz gadget. For instance you can use the Saxon XSLT engine at [http://sourceforge.net/projects/saxon/](http://sourceforge.net/projects/saxon/) :

    java -cp saxon9.jar net.sf.saxon.Transform  -xsl:generator.xsl -o:continent.html continent.xml
    
You can also change some XSLT tranformation parameter directly from the command line :

    java -cp saxon9.jar net.sf.saxon.Transform  -xsl:generator.xsl -o:continent.html continent.xml  xslt.base-url=some/other/path

Then open the resulting file `continent.html` inside your browser to run the quizz.

## How to edit / create a Quizz document ?

To edit a Quizz document you need first to checkout the AXEL-FORMS and the AXEL (Adaptable XML Editing Library) libraries at [https://github.com/ssire/axel-forms](https://github.com/ssire/axel-forms) and [https://github.com/ssire/axel](https://github.com/ssire/axel). Eventually follow the instructions to build a fresh `axel-forms.js` and `axel.js` library with the latest version of the source files, otherwise they come with pre-built ones that may not correspond to the latest commit but that should be sufficient.

Then open `editor/editor.html` from the AXEL-FORMS distribution inside your browser (Firefox recommended if you run it directly from your file system). This is a sample application built with AXEL-FORMS and AXEL. You can use it to transform XTiger XML template documents into editors.

It is important to checkout the 3 projects inside the same parent folder, so you should have them side-by-side:

    axel/
    axel-forms/
    quizz/

To load the XTiger template `quizz-en.xhtml` into the editor enter its URL into the `Template file` field, then hit "Transform" (these commands refer to the corresponding buttons of the application user interface). To get the XML document corresponding to the current Quizz document hit the "Dump" button, then you can cut-and-past the result into a file. You can load an Quizz document into the editor using the "Load" button. Note that due to current limitation it is advised to "Visualize" again the template each time you want to reload some new data.

## How to integrate this module on a server ?

You need to build the AXEL library and copy it to your server (see AXEL instructions).

Then you can transform the `quizz-en.xhtml` template inside any of your web page to generate an editor and load / save some edited XML data (see AXEL tutorials) into it.

To generate the Quizz gadget you need to process a Quizz XML document with the `generator.xsl` transformation. This can be done server side or client side, depending on your architecture.

## What to do with the Quizz gadget ?

Feel free to extend the Quizz data model to support new types of exercices. Then extend the Javascript runtime code to support them. The runtime code is in `resources/quizz.js`. Finally extend the XTiger template `quizz-en.xhtml` to support the editing of these new features. 

Do not hesitate to contact me <[s.sire@oppidoc.fr](mailto:s.sire@oppidoc.fr)> if you want to know more about structured document editing in the browser and its applications.
