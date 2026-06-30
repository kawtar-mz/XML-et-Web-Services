<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <xsl:template match="releve">
        <html>
            <head>
                <title>Relevé Bancaire - Opérations de CRÉDIT</title>
                <style>
                    body { font-family: Arial, sans-serif; margin: 20px; background-color: #f4f4f9; }
                    .releve-container { background-color: white; padding: 20px; border-radius: 8px; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); }
                    h2 { color: #333; border-bottom: 2px solid #5cb85c; padding-bottom: 5px; }
                    table { width: 100%; border-colla   pse: collapse; margin-top: 20px; }
                    th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }
                    th { background-color: #5cb85c; color: white; }
                    .credit { color: green; font-weight: bold; }
                    .total-box { margin-top: 20px; padding: 15px; border: 1px solid #ccc; border-radius: 5px; background-color: #eafaea; }
                    .total-credit { color: green; font-size: 1.2em; }
                </style>
            </head>
            <body>
                <div class="releve-container">
                    <h1>💰 Opérations de CRÉDIT Uniquement</h1>
                    <p><strong>RIB :</strong> <xsl:value-of select="@RIB"/></p>
                    
                    <xsl:apply-templates select="operations"/>
                    
                    <div class="total-box">
                        <h2>Total Crédits</h2>
                        <p class="total-credit">
                            <xsl:variable name="total_credit">
                                <xsl:value-of select="sum(operations/operation[@type='CREDIT']/@montant)"/>
                            </xsl:variable>
                            Montant Total Crédité : **<xsl:value-of select="format-number($total_credit, '0.00')"/> €**
                        </p>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>
    
  
        <xsl:template match="operations">
            <h2>Détail des Crédits (Du <xsl:value-of select="@dateDebut"/> au <xsl:value-of select="@dateFin"/>)</h2>
            <table>
                <thead>
                    <tr>
                        <th>Date</th>
                        <th>Description</th>
                        <th style="text-align: right;">Montant (€)</th>
                    </tr>
                </thead>
                <tbody>
                    <xsl:apply-templates select="operation[@type='CREDIT']"/>
                </tbody>
            </table>
        </xsl:template>
        
      
            
            <xsl:template match="operation">
                <tr>
                    <td><xsl:value-of select="@date"/></td>
                    <td><xsl:value-of select="@description | @desciption"/></td> 
                    <td style="text-align: right;" class="credit">
                        <xsl:value-of select="format-number(@montant, '0.00')"/>
                    </td>
                </tr>
            </xsl:template>
            
</xsl:stylesheet>