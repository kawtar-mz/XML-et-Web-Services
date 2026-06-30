<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    version="3.0"> 
    <xsl:template match="/">
        <html>
            <head>
                <title> METEO</title>
            </head>
            <body>
                <xsl:for-each select="meteo/mesure[@date='2024-03-13']">
                    <ul>
                        <li>DATE MESURE : <xsl:value-of select="@date"/></li>
                    </ul>
                    <table border="1" width="90%">
                    <tr>
                        <th> ville</th>
                        <th>temperature</th>
                    </tr>
                        <xsl:for-each select="ville">
                            <tr>
                                <td> <xsl:value-of select="@nom"/></td>
                                <td> <xsl:value-of select="@temperature"/></td>
                                
                            </tr>
                        </xsl:for-each>
                        <tr>
                            <td> nombre de ville </td>
                            <td> <xsl:value-of select="count(ville )"/></td>
                        </tr>
                        <tr>
                            <td> temperature moyenne</td>
                            <td> <xsl:value-of select="avg(ville/@temperature)"/></td>
                        </tr>
                        
                    </table>
                </xsl:for-each>
            </body>
        </html>
        
        
        
    </xsl:template>
    
</xsl:stylesheet>