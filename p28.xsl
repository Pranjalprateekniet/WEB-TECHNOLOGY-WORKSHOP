<?xml version="1.0" encoding="UTF-8"?>
<!-- XSL Stylesheet for College Data Transformation -->
<!-- Student: Pranjal Prateek | Branch: IT-C | College: NIET -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" indent="yes"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <title>College Management System - XSL Demo</title>
                <style>
                    body { font-family: Arial, sans-serif; margin: 20px; background: linear-gradient(135deg, #667eea, #764ba2); min-height: 100vh; }
                    .container { max-width: 1000px; margin: 0 auto; background: white; padding: 30px; border-radius: 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.2); }
                    .header { background: linear-gradient(45deg, #fd79a8, #fdcb6e); color: white; padding: 20px; border-radius: 10px; text-align: center; margin-bottom: 25px; }
                    .section { margin: 25px 0; padding: 20px; background: #f8f9fa; border-radius: 10px; border-left: 5px solid #667eea; }
                    table { width: 100%; border-collapse: collapse; margin: 15px 0; background: white; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
                    th { background: linear-gradient(45deg, #74b9ff, #0984e3); color: white; padding: 12px; text-align: left; }
                    td { padding: 10px; border-bottom: 1px solid #ddd; }
                    tr:hover { background: #f1f3f4; }
                    .high-cgpa { background: #d4edda; color: #155724; font-weight: bold; }
                    .college-info { background: #e3f2fd; padding: 15px; border-radius: 8px; margin: 15px 0; }
                    .metadata { background: #fff3cd; padding: 10px; border-radius: 5px; font-size: 12px; color: #856404; }
                </style>
            </head>
            <body>
                <div class="container">
                    <div class="header">
                        <h1>XSL Transformation Demo</h1>
                        <p>Student: Pranjal Prateek | Branch: IT-C | Subject: Web Technology | College: NIET</p>
                    </div>
                    
                    <!-- College Information -->
                    <div class="section">
                        <h2>🏫 College Information</h2>
                        <div class="college-info">
                            <xsl:for-each select="college_data/college_info">
                                <h3><xsl:value-of select="full_name"/> (<xsl:value-of select="name"/>)</h3>
                                <p><strong>Location:</strong> <xsl:value-of select="location"/></p>
                                <p><strong>Established:</strong> <xsl:value-of select="established"/></p>
                                <p><strong>Website:</strong> <xsl:value-of select="website"/></p>
                            </xsl:for-each>
                        </div>
                    </div>
                    
                    <!-- Students Information -->
                    <div class="section">
                        <h2>👥 Students Information</h2>
                        <table>
                            <tr>
                                <th>S.No</th>
                                <th>Name</th>
                                <th>Student ID</th>
                                <th>Branch</th>
                                <th>Semester</th>
                                <th>CGPA</th>
                                <th>Email</th>
                                <th>Phone</th>
                            </tr>
                            <xsl:for-each select="college_data/students/student">
                                <xsl:sort select="cgpa" order="descending" data-type="number"/>
                                <tr>
                                    <td><xsl:value-of select="position()"/></td>
                                    <td><xsl:value-of select="name"/></td>
                                    <td><xsl:value-of select="student_id"/></td>
                                    <td><xsl:value-of select="branch"/></td>
                                    <td><xsl:value-of select="semester"/></td>
                                    <td>
                                        <xsl:choose>
                                            <xsl:when test="cgpa &gt;= 9.0">
                                                <span class="high-cgpa"><xsl:value-of select="cgpa"/></span>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:value-of select="cgpa"/>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </td>
                                    <td><xsl:value-of select="email"/></td>
                                    <td><xsl:value-of select="phone"/></td>
                                </tr>
                            </xsl:for-each>
                        </table>
                        
                        <div style="margin-top: 15px;">
                            <strong>Statistics:</strong>
                            <ul>
                                <li>Total Students: <xsl:value-of select="count(college_data/students/student)"/></li>
                                <li>High Performers (CGPA ≥ 9.0): <xsl:value-of select="count(college_data/students/student[cgpa >= 9.0])"/></li>
                                <li>Average CGPA: <xsl:value-of select="format-number(sum(college_data/students/student/cgpa) div count(college_data/students/student), '#.##')"/></li>
                            </ul>
                        </div>
                    </div>
                    
                    <!-- Courses Information -->
                    <div class="section">
                        <h2>📚 Course Information</h2>
                        <table>
                            <tr>
                                <th>Course Name</th>
                                <th>Course Code</th>
                                <th>Credits</th>
                                <th>Instructor</th>
                                <th>Type</th>
                            </tr>
                            <xsl:for-each select="college_data/courses/course">
                                <tr>
                                    <td><xsl:value-of select="name"/></td>
                                    <td><xsl:value-of select="code"/></td>
                                    <td><xsl:value-of select="credits"/></td>
                                    <td><xsl:value-of select="instructor"/></td>
                                    <td><xsl:value-of select="type"/></td>
                                </tr>
                            </xsl:for-each>
                        </table>
                        
                        <div style="margin-top: 15px;">
                            <strong>Total Credits:</strong> <xsl:value-of select="sum(college_data/courses/course/credits)"/>
                        </div>
                    </div>
                    
                    <!-- Top Performers -->
                    <div class="section">
                        <h2>🏆 Top Performers (CGPA ≥ 8.0)</h2>
                        <table>
                            <tr>
                                <th>Rank</th>
                                <th>Name</th>
                                <th>CGPA</th>
                                <th>Performance</th>
                            </tr>
                            <xsl:for-each select="college_data/students/student[cgpa >= 8.0]">
                                <xsl:sort select="cgpa" order="descending" data-type="number"/>
                                <tr>
                                    <td><xsl:value-of select="position()"/></td>
                                    <td><xsl:value-of select="name"/></td>
                                    <td class="high-cgpa"><xsl:value-of select="cgpa"/></td>
                                    <td>
                                        <xsl:choose>
                                            <xsl:when test="cgpa >= 9.0">Excellent</xsl:when>
                                            <xsl:when test="cgpa >= 8.5">Very Good</xsl:when>
                                            <xsl:otherwise>Good</xsl:otherwise>
                                        </xsl:choose>
                                    </td>
                                </tr>
                            </xsl:for-each>
                        </table>
                    </div>
                    
                    <!-- Document Metadata -->
                    <div class="metadata">
                        <strong>Document Info:</strong>
                        Created on <xsl:value-of select="college_data/metadata/created_date"/> by 
                        <xsl:value-of select="college_data/metadata/created_by"/> | 
                        Purpose: <xsl:value-of select="college_data/metadata/purpose"/> | 
                        Subject: <xsl:value-of select="college_data/metadata/subject"/>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>