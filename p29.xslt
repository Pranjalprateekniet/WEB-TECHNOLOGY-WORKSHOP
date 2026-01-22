<?xml version="1.0" encoding="UTF-8"?>
<!-- Advanced XSLT Stylesheet with Functions and Variables -->
<!-- Student: Pranjal Prateek | Branch: IT-C | College: NIET -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" indent="yes" doctype-public="-//W3C//DTD HTML 4.01//EN"/>
    
    <!-- Global Variables -->
    <xsl:variable name="total_students" select="count(/academic_system/students/student)"/>
    <xsl:variable name="avg_cgpa" select="sum(/academic_system/students/student/cgpa) div $total_students"/>
    <xsl:variable name="total_credits" select="sum(/academic_system/courses/course/credits)"/>
    <xsl:variable name="current_date" select="/academic_system/system_info/report_date"/>
    
    <!-- Main Template -->
    <xsl:template match="/">
        <html>
            <head>
                <title>Advanced XSLT Academic Report</title>
                <style>
                    body { font-family: 'Segoe UI', Arial, sans-serif; margin: 0; padding: 20px; background: linear-gradient(135deg, #667eea, #764ba2); min-height: 100vh; }
                    .container { max-width: 1200px; margin: 0 auto; background: white; border-radius: 15px; box-shadow: 0 15px 35px rgba(0,0,0,0.1); overflow: hidden; }
                    .header { background: linear-gradient(45deg, #667eea, #764ba2); color: white; padding: 30px; text-align: center; }
                    .header h1 { margin: 0; font-size: 2.5em; text-shadow: 2px 2px 4px rgba(0,0,0,0.3); }
                    .section { margin: 30px; padding: 25px; background: #f8f9fa; border-radius: 10px; border-left: 5px solid #667eea; }
                    .stats-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px; margin: 20px 0; }
                    .stat-card { background: white; padding: 20px; border-radius: 10px; text-align: center; box-shadow: 0 4px 8px rgba(0,0,0,0.1); }
                    .stat-number { font-size: 2em; font-weight: bold; color: #667eea; }
                    .stat-label { color: #666; margin-top: 5px; }
                    table { width: 100%; border-collapse: collapse; margin: 20px 0; background: white; border-radius: 10px; overflow: hidden; box-shadow: 0 4px 8px rgba(0,0,0,0.1); }
                    th { background: linear-gradient(45deg, #74b9ff, #0984e3); color: white; padding: 15px; text-align: left; font-weight: 600; }
                    td { padding: 12px 15px; border-bottom: 1px solid #eee; }
                    tr:hover { background: #f1f3f4; }
                    .excellent { background: #d4edda; color: #155724; font-weight: bold; border-radius: 4px; padding: 2px 6px; }
                    .good { background: #cce5ff; color: #004085; font-weight: bold; border-radius: 4px; padding: 2px 6px; }
                    .average { background: #fff3cd; color: #856404; border-radius: 4px; padding: 2px 6px; }
                    .hostel { color: #28a745; font-weight: bold; }
                    .local { color: #007bff; font-weight: bold; }
                    .project-active { color: #28a745; }
                    .project-completed { color: #6c757d; }
                    .project-planning { color: #ffc107; }
                    .footer { background: #2c3e50; color: white; padding: 20px; text-align: center; }
                </style>
            </head>
            <body>
                <div class="container">
                    <!-- Header -->
                    <div class="header">
                        <h1>Academic Performance Report</h1>
                        <p>Advanced XSLT Transformation Demo</p>
                        <p>Student: Pranjal Prateek | Branch: IT-C | College: NIET</p>
                        <p>Report Generated: <xsl:value-of select="$current_date"/></p>
                    </div>
                    
                    <!-- System Information -->
                    <div class="section">
                        <h2>📊 System Overview</h2>
                        <xsl:apply-templates select="academic_system/system_info"/>
                        
                        <div class="stats-grid">
                            <div class="stat-card">
                                <div class="stat-number"><xsl:value-of select="$total_students"/></div>
                                <div class="stat-label">Total Students</div>
                            </div>
                            <div class="stat-card">
                                <div class="stat-number"><xsl:value-of select="format-number($avg_cgpa, '#.##')"/></div>
                                <div class="stat-label">Average CGPA</div>
                            </div>
                            <div class="stat-card">
                                <div class="stat-number"><xsl:value-of select="$total_credits"/></div>
                                <div class="stat-label">Total Credits</div>
                            </div>
                            <div class="stat-card">
                                <div class="stat-number"><xsl:value-of select="count(/academic_system/students/student[cgpa >= 9.0])"/></div>
                                <div class="stat-label">Excellent Students</div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Students Performance -->
                    <div class="section">
                        <h2>🎓 Student Performance Analysis</h2>
                        <table>
                            <tr>
                                <th>Rank</th>
                                <th>Name</th>
                                <th>Student ID</th>
                                <th>CGPA</th>
                                <th>Grade</th>
                                <th>Attendance</th>
                                <th>Category</th>
                                <th>Projects</th>
                            </tr>
                            <xsl:for-each select="academic_system/students/student">
                                <xsl:sort select="cgpa" order="descending" data-type="number"/>
                                <tr>
                                    <td><xsl:value-of select="position()"/></td>
                                    <td><xsl:value-of select="name"/></td>
                                    <td><xsl:value-of select="student_id"/></td>
                                    <td>
                                        <xsl:call-template name="format-cgpa">
                                            <xsl:with-param name="cgpa" select="cgpa"/>
                                        </xsl:call-template>
                                    </td>
                                    <td>
                                        <xsl:call-template name="get-grade">
                                            <xsl:with-param name="cgpa" select="cgpa"/>
                                        </xsl:call-template>
                                    </td>
                                    <td><xsl:value-of select="attendance"/>%</td>
                                    <td>
                                        <span>
                                            <xsl:attribute name="class">
                                                <xsl:value-of select="@category"/>
                                            </xsl:attribute>
                                            <xsl:choose>
                                                <xsl:when test="@category = 'hostel'">🏠 Hostel</xsl:when>
                                                <xsl:otherwise>🏘️ Local</xsl:otherwise>
                                            </xsl:choose>
                                        </span>
                                    </td>
                                    <td><xsl:value-of select="count(projects/project)"/></td>
                                </tr>
                            </xsl:for-each>
                        </table>
                    </div>
                    
                    <!-- Category-wise Analysis -->
                    <div class="section">
                        <h2>📈 Category-wise Analysis</h2>
                        <div class="stats-grid">
                            <div class="stat-card">
                                <div class="stat-number"><xsl:value-of select="count(/academic_system/students/student[@category='hostel'])"/></div>
                                <div class="stat-label">Hostel Students</div>
                            </div>
                            <div class="stat-card">
                                <div class="stat-number"><xsl:value-of select="count(/academic_system/students/student[@category='local'])"/></div>
                                <div class="stat-label">Local Students</div>
                            </div>
                            <div class="stat-card">
                                <div class="stat-number">
                                    <xsl:value-of select="format-number(sum(/academic_system/students/student[@category='hostel']/cgpa) div count(/academic_system/students/student[@category='hostel']), '#.##')"/>
                                </div>
                                <div class="stat-label">Hostel Avg CGPA</div>
                            </div>
                            <div class="stat-card">
                                <div class="stat-number">
                                    <xsl:value-of select="format-number(sum(/academic_system/students/student[@category='local']/cgpa) div count(/academic_system/students/student[@category='local']), '#.##')"/>
                                </div>
                                <div class="stat-label">Local Avg CGPA</div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Project Analysis -->
                    <div class="section">
                        <h2>💼 Project Analysis</h2>
                        <table>
                            <tr>
                                <th>Student Name</th>
                                <th>Total Projects</th>
                                <th>Active</th>
                                <th>Completed</th>
                                <th>Planning</th>
                                <th>Project Details</th>
                            </tr>
                            <xsl:for-each select="academic_system/students/student">
                                <xsl:sort select="count(projects/project)" order="descending"/>
                                <tr>
                                    <td><xsl:value-of select="name"/></td>
                                    <td><xsl:value-of select="count(projects/project)"/></td>
                                    <td class="project-active"><xsl:value-of select="count(projects/project[@status='active'])"/></td>
                                    <td class="project-completed"><xsl:value-of select="count(projects/project[@status='completed'])"/></td>
                                    <td class="project-planning"><xsl:value-of select="count(projects/project[@status='planning'])"/></td>
                                    <td>
                                        <xsl:for-each select="projects/project">
                                            <span>
                                                <xsl:attribute name="class">project-<xsl:value-of select="@status"/></xsl:attribute>
                                                <xsl:value-of select="."/>
                                                <xsl:if test="position() != last()">, </xsl:if>
                                            </span>
                                        </xsl:for-each>
                                    </td>
                                </tr>
                            </xsl:for-each>
                        </table>
                    </div>
                    
                    <!-- Course Information -->
                    <div class="section">
                        <h2>📚 Course Information</h2>
                        <xsl:apply-templates select="academic_system/courses"/>
                    </div>
                    
                    <!-- Footer -->
                    <div class="footer">
                        <p>Generated using Advanced XSLT | Web Technology Course | NIET</p>
                        <p>Demonstrates: Variables, Functions, Sorting, Conditional Logic, and Advanced Formatting</p>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>
    
    <!-- Template for System Info -->
    <xsl:template match="system_info">
        <div style="background: white; padding: 15px; border-radius: 8px; margin: 15px 0;">
            <h3><xsl:value-of select="college"/> - <xsl:value-of select="department"/></h3>
            <p><strong>Academic Year:</strong> <xsl:value-of select="academic_year"/> | 
               <strong>Semester:</strong> <xsl:value-of select="semester"/> | 
               <strong>Report Date:</strong> <xsl:value-of select="report_date"/></p>
        </div>
    </xsl:template>
    
    <!-- Template for Courses -->
    <xsl:template match="courses">
        <table>
            <tr>
                <th>Course Name</th>
                <th>Code</th>
                <th>Credits</th>
                <th>Instructor</th>
                <th>Type</th>
            </tr>
            <xsl:for-each select="course">
                <tr>
                    <td><xsl:value-of select="name"/></td>
                    <td><xsl:value-of select="code"/></td>
                    <td><xsl:value-of select="credits"/></td>
                    <td><xsl:value-of select="instructor"/></td>
                    <td><xsl:value-of select="type"/></td>
                </tr>
            </xsl:for-each>
        </table>
    </xsl:template>
    
    <!-- Named Template for CGPA Formatting -->
    <xsl:template name="format-cgpa">
        <xsl:param name="cgpa"/>
        <span>
            <xsl:choose>
                <xsl:when test="$cgpa >= 9.0">
                    <xsl:attribute name="class">excellent</xsl:attribute>
                </xsl:when>
                <xsl:when test="$cgpa >= 8.0">
                    <xsl:attribute name="class">good</xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="class">average</xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:value-of select="$cgpa"/>
        </span>
    </xsl:template>
    
    <!-- Named Template for Grade Calculation -->
    <xsl:template name="get-grade">
        <xsl:param name="cgpa"/>
        <xsl:choose>
            <xsl:when test="$cgpa >= 9.0">A+</xsl:when>
            <xsl:when test="$cgpa >= 8.5">A</xsl:when>
            <xsl:when test="$cgpa >= 8.0">B+</xsl:when>
            <xsl:when test="$cgpa >= 7.5">B</xsl:when>
            <xsl:when test="$cgpa >= 7.0">C+</xsl:when>
            <xsl:otherwise>C</xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>