<?xml version="1.0" encoding="UTF-8"?>
<!-- 
     Initial version by Oppidoc SARL, <contact@oppidoc.fr>

     Author: Stéphane Sire <s.sire@opppidoc.fr>

     Quizz generator
  -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" version="1.0">
  
  <!-- <xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" doctype-system="about:legacy-compat" indent="yes"/>   -->
  <!-- sets output method to "html" otherwise Firefox makes an XML dom without document.body and jQuery.ready loops (!)  -->
  <xsl:output method="html" omit-xml-declaration="yes" indent="yes"/>
  
  <xsl:param name="xslt.base-url">resources/</xsl:param> 

  <!--  Constants (set your own) -->
  <xsl:variable name="path.quizz.css"><xsl:value-of select="$xslt.base-url"/>quizz.css</xsl:variable>
  <xsl:variable name="path.jquery">https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js</xsl:variable>
  <xsl:variable name="path.quizz.js"><xsl:value-of select="$xslt.base-url"/>quizz.js</xsl:variable>
  
  <xsl:template match="/">
    <html xmlns="http://www.w3.org/1999/xhtml">
      <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <title>Quizz</title>
        <link rel="stylesheet" href="{$path.quizz.css}" type="text/css" charset="utf-8"/>
        <script type="text/javascript" charset="utf-8" src="{$path.jquery}">//</script>
        <script type="text/javascript" charset="utf-8" src="{$path.quizz.js}">//</script>
      </head>
      <body>
        <!-- sets a kind of "viewport", required for iPad... -->
        <div style="width:500px;height:300px;overflow:hidden;position:relative">
          <div id="ui-prev">
            <button onclick="javascript:$quizz.prevItem()">Review errors</button>
          </div>
          <div id="ui-next">
            <button onclick="javascript:$quizz.nextItem()">Play</button>
          </div>
          <xsl:call-template name="prologue"/>
          <xsl:apply-templates select="Quizz/Item"/>
          <xsl:call-template name="epilogue"/>
        </div>
      </body>
    </html>
  </xsl:template>
  
  <xsl:template match="Item">
    <div class="x-Item">
      <xsl:apply-templates select="Question"/>
      <xsl:apply-templates select="Choices"/>
    </div>
  </xsl:template>
  
  <xsl:template match="Question">
    <div class="x-Question">
      <p><xsl:value-of select="."/></p>
    </div>  
  </xsl:template>
  
  <xsl:template match="Choices">
    <ul class="x-Choices">
      <xsl:apply-templates select="Choice"/>
    </ul>
  </xsl:template>
  
  <xsl:template match="Choice">
    <li>
      <xsl:apply-templates select="@State"/>
      <xsl:apply-templates select="Answer"/>
      <xsl:apply-templates select="Explain"/>
    </li>
  </xsl:template>
  
  <xsl:template match="@State[. = 'incorrect']">
    <xsl:attribute name="class">x-Incorrect</xsl:attribute>
  </xsl:template>

  <xsl:template match="@State[. = 'correct']">
    <xsl:attribute name="class">x-Correct</xsl:attribute>
  </xsl:template>
  
  <xsl:template match="Answer[count(ancestor::Choices/Choice[@State='correct'])>1]">
    <p class="x-Answer"><label><input type="checkbox"><xsl:attribute name="name"><xsl:value-of select="concat('q', count(ancestor::Item/preceding-sibling::Item) + 1)"/></xsl:attribute></input><xsl:value-of select="."/></label></p>
  </xsl:template>
 
  <xsl:template match="Answer">
    <p class="x-Answer"><label><input type="radio"><xsl:attribute name="name"><xsl:value-of select="concat('q', count(ancestor::Item/preceding-sibling::Item) + 1)"/></xsl:attribute></input><xsl:value-of select="."/></label></p>
  </xsl:template>  
  
  <xsl:template match="Explain">
    <p class="x-Explain"><xsl:value-of select="."/></p>
  </xsl:template>
  
  <xsl:template name="prologue">
    <div class="x-Item cur">
      <h1><xsl:value-of select="/Quizz/Title"/></h1>
      <p class="x-Comment"><xsl:value-of select="/Quizz/Comment"/></p>
      <p>Click “Play” to start answering</p>      
    </div>
  </xsl:template>

  <xsl:template name="epilogue">
    <div class="x-Item">
      <p>The quizz is other</p>
      <p class="v-results">You have <span id="good">x</span> good answers on a total of <span id="total">y</span> questions</p>
    </div>
  </xsl:template>
  
</xsl:stylesheet>
