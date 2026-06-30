<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <xsl:template match="releve">
        <html>
            <head>
                <title>Relevé Bancaire - RIB: <xsl:value-of select="@RIB"/></title>
                <style>
                    body { font-family: Arial, sans-serif; margin: 20px; background-color: #f4f4f9; }
                    .releve-container { background-color: white; padding: 20px; border-radius: 8px; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); }
                    h2 { color: #333; border-bottom: 2px solid #5cb85c; padding-bottom: 5px; }
                    table { width: 100%; border-collapse: collapse; margin-top: 20px; }
                    th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }
                    th { background-color: #5cb85c; color: white; }
                    .credit { color: green; font-weight: bold; }
                    .debit { color: red; }
                    .total-box { margin-top: 20px; padding: 15px; border: 1px solid #ccc; border-radius: 5px; background-color: #eafaea; }
                    .total-credit { color: green; font-size: 1.1em; }
                    .total-debit { color: red; font-size: 1.1em; }
                </style>
            </head>
            <body>
                <div class="releve-container">
                    <h1>💳 Relevé de Compte</h1>
                    
                    <p><strong>RIB :</strong> <xsl:value-of select="@RIB"/></p>
                    <p><strong>Date du Relevé :</strong> <xsl:value-of select="dateReleve"/></p>
                    <p><strong>Solde au Relevé :</strong> <span style="font-size: 1.2em; color: blue;"><xsl:value-of select="solde"/> €</span></p>
                    
                    <xsl:apply-templates select="operations"/>
                    
                    <div class="total-box">
                        <h2>Total des Opérations</h2>
                        
                        <p class="total-credit">
                            <strong>Total des Crédits :</strong> 
                            <xsl:variable name="total_credit">
                                <xsl:value-of select="sum(operations/operation[@type='CREDIT']/@montant)"/>
                            </xsl:variable>
                            <xsl:value-of select="format-number($total_credit, '0.00')"/> €
                        </p>
                        
                        <p class="total-debit">
                            <strong>Total des Débits :</strong> 
                            <xsl:variable name="total_debit">
                                <xsl:value-of select="sum(operations/operation[@type='DEBIT']/@montant)"/>
                            </xsl:variable>
                            <xsl:value-of select="format-number($total_debit, '0.00')"/> €
                        </p>
                        
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="operations">
        <h2>Détail des Opérations (Du <xsl:value-of select="@dateDebut"/> au <xsl:value-of select="@dateFin"/>)</h2>
        <table>
            <thead>
                <tr>
                    <th>Date</th>
                    <th>Description</th>
                    <th>Type</th>
                    <th style="text-align: right;">Montant (€)</th>
                </tr>
            </thead>
            <tbody>
                <xsl:apply-templates select="operation"/>
            </tbody>
        </table>
    </xsl:template>
    
    <xsl:template match="operation">
        <tr>
            <td><xsl:value-of select="@date"/></td>
            
            <td><xsl:value-of select="@description | @desciption"/></td> 
            
            <td>
                <xsl:choose>
                    <xsl:when test="@type = 'CREDIT'">
                        <span class="credit">CRÉDIT</span>
                    </xsl:when>
                    <xsl:otherwise>
                        <span class="debit">DÉBIT</span>
                    </xsl:otherwise>
                </xsl:choose>
            </td>
            <td style="text-align: right;">
                <xsl:value-of select="format-number(@montant, '0.00')"/>
            </td>
        </tr>
    </xsl:template>
    
</xsl:stylesheet>