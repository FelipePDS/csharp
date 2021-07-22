# <h1 align="center">C-SHARP</h1>

<p align="center">
  <a href="https://github.com/FelipePDS/csharp/blob/main/LICENSE"><img src="https://img.shields.io/github/license/Felipepds/csharp?style=for-the-badge"/></a> 
  <img src="https://img.shields.io/github/last-commit/FelipePDS/csharp?style=for-the-badge"/>
  <img src="https://img.shields.io/static/v1?label=ASP.NET&message=v5&color=512BD4&style=for-the-badge"/> 
  <img src="https://img.shields.io/static/v1?label=Visual+Studio&message=community+2019&color=5C2D91&style=for-the-badge&logo=VisualStudio"/> 
</p>

<br>
<h2 align="center">Topics</h2>

<p align="center">
  <a href="#objective">:dart: Objective</a> &bull; 
  <a href="#technologies">:computer: Technologies</a> &bull; 
  <a href="#clone">:open_file_folder: Clone Subdirectories</a> <br>
  <a href="#exercises">:pushpin: Exercises and Mini Project</a> &bull; 
  <a href="#author">:bust_in_silhouette: Author</a> &bull; 
  <a href="#license">:page_with_curl: License</a>
</p>

<br>
<h2 id="objective" align="center">:dart: Objective</h2>

<p align="center">Mini-projects and exercises in C# and ASP.NET Core 5, projects and exercises are tutorials and documentation, where anyone has access.</p>

<br>
<h2 align="center" id="technologies">:computer: Technologies</h2>

<p align="center">
  &bull; <a href="https://dotnet.microsoft.com/learn/csharp">C#</a> <br>
  &bull; <a href="https://asp.net/">Asp.net Core 5</a> <br>
  &bull; <a href="https://docs.microsoft.com/pt-br/sql/ssms/download-sql-server-management-studio-ssms">SQL Server</a> <br>
  &bull; <a href="https://visualstudio.microsoft.com/pt-br/downloads/">Code Editor - Visual Studio 2019</a>
</p>

<br>
<h2 align="center" id="clone">:open_file_folder: Clone Subdirectories</h2>

<p align="center">If you want to clone one of the exercises (subdirectories), just have <kbd><a href="https://git-scm.com/downloads">git bash</a></kbd> on your computer to give the following commands</p>

```bash
# create a folder with the name of the exercise and enter it
$ mkdir name-dir && cd name-dir

# start a git repository to access the repository
$ git init

# crawl the repositorie
$ git remote add -f origin https://github.com/FelipePDS/csharp

# active sparse checkout
$ git config core.sparseCheckout true

# Create a file in the path: .git/csharp/sparse-checkout
# And insert the name of the subdirectory you want to clone
$ echo 'nameOfTheSubdirectory' >> .git/csharp/sparse-checkout

# pull the subdirectory
$ git pull origin master
```
<blockquote>Font: <a href="https://terminalroot.com.br/2019/09/como-clonar-somente-um-subdiretorio-com-git-ou-svn.html">terminalroot.com.br</a></blockquote>

<p>If you want to clone the entire project: <code>$ git clone https://github.com/FelipePDS/csharp.git</code></p>

<br>
<h2 id="exercises" align="center">:pushpin: Exercises and Mini Project</h2>

<table align="center">
  <tr align="center">
    <th>REPO</th>
    <th>DESCRIPTION</th>
    <th>DATE</th>
    <th>STATUS</th>
  </tr>
  <tr align="center">
    <td><kbd><a href="https://github.com/FelipePDS/csharp/tree/main/Classes">Classes</a></kbd></td>
    <td>Introduction to Classes in C# with a Bank Account Simulation</td>
    <td>2021/07/02</td>
    <td>:heavy_check_mark:</td>
  </tr>
  <tr align="center">
    <td><kbd><a href="https://github.com/FelipePDS/csharp/tree/main/ClassInheritance">Classes Inheritance</a></kbd></td>
    <td>Representation of uses of class inheritance in C#. <br><a href="https://github.com/FelipePDS/csharp/tree/main/ClassInheritance/ClassInheritance">ClassInheritance1</a>: Simulation of publications of books, newspapers, magazines... <br><a href="https://github.com/FelipePDS/csharp/tree/main/ClassInheritance/ClassInheritance2">ClassInheritance2</a>: Calculation of area, perimeter and other characteristics of geometric figures</td>
    <td>2021/07/05</td>
    <td>:heavy_check_mark:</td>
  </tr>
  <tr align="center">
    <td><kbd><a href="https://github.com/FelipePDS/csharp/tree/main/TypeConversion">Type Conversion</a></kbd></td>
    <td>How to cast safely using pattern matching and the is and as operators</td>
    <td>2021/07/05</td>
    <td>:heavy_check_mark:</td>
  </tr>
  <tr align="center">
    <td><kbd><a href="https://github.com/FelipePDS/csharp/tree/main/PatternMatching">Pattern Matching</a></kbd></td>
    <td>How to Use Pattern Matching to Create Type-Driven and Data-Driven Algorithms</td>
    <td>2021/07/06</td>
    <td>:heavy_check_mark:</td>
  </tr>
  <tr align="center">
    <td><kbd><a href="https://github.com/FelipePDS/csharp/tree/main/RazorPagesMovie">Razor Pages</a></kbd></td>
    <td>Mini movie management project (CRUD System) using Razor Pages and Entity Framework</td>
    <td>2021/07/07</td>
    <td>:heavy_check_mark:</td>
  </tr>
  <tr align="center">
    <td><kbd><a href="https://github.com/FelipePDS/csharp/tree/main/MvcMovie">Mvc Movie</a></kbd></td>
    <td>Creating a movie list and its characteristics with an ASP.NET MVC 5 in C#</td>
    <td>2021/07/10</td>
    <td>:heavy_check_mark:</td>
  </tr>
  <tr align="center">
    <td><kbd><a href="https://github.com/FelipePDS/csharp/tree/main/BikeStores">Bike Stores</a></kbd></td>
    <td>Simulation of a Bike Store to perform a list of sql-server commands to practice. <br>Tutorial: <a href="https://sqlservertutorial.net/">sqlservertutorial.net</a></td>
    <td>2021/07/11</td>
    <td>:construction:</td>
  </tr>
  <tr align="center">
    <td><kbd><a href="https://github.com/FelipePDS/csharp/tree/main/CRUDUsingMVCWithAdoNet">CRUD Using MVC With Ado Net</a></kbd></td>
    <td>Asp.net 5 MVC with Ado Net in c#: CRUD system to list people registered in the database. <br>Tutorial: <a href="https://www.treinaweb.com.br/blog/operacoes-crud-no-asp-net-mvc-5-com-o-ado-net">treinaweb.com.br</a></td>
    <td>2021/07/12</td>
    <td>:heavy_check_mark:</td>
  </tr>
  <tr align="center">
    <td><kbd><a href="https://github.com/FelipePDS/csharp/tree/main/SmallBakery">Small Bakery</a></kbd></td>
    <td>Managing files through an MVC project</td>
    <td>2021/07/15</td>
    <td>:heavy_check_mark:</td>
  </tr>
</table>

<br>
<h2 align="center" id="author">:bust_in_silhouette: Author</h2>

<p align="center">:pencil: by <a href="https://felipepds.github.io//">FelipePDS</a></p>
<p align="center"><a href="https://www.linkedin.com/in/felipe-p-da-silva-a55b891ba/?lipi=urn%3Ali%3Apage%3Ad_flagship3_feed%3BiErPy3g7Q1KGOaD%2BsGw%2Fpg%3D%3D"><img src="https://img.shields.io/static/v1?label=+&message=Felipe+P.+Da+Silva&color=0A66C2&style=flat&logo=linkedin&logoColor=white"/></a> <a href="https://twitter.com/FelipePintoDaS1"><img src="https://img.shields.io/static/v1?label=+&message=@FelipePintoDaS1&color=1DA1F2&style=flat&logo=twitter&logoColor=white"/></a> <img src="https://img.shields.io/static/v1?label=+&message=felipepdasilva66@gmail.com&color=EA4335&style=flat&logo=gmail&logoColor=white"/></p>

<br>
<h2 align="center" id="license">:page_with_curl: License</h2>

<p align="center"><a href="https://github.com/FelipePDS/csharp/blob/main/LICENSE">MIT License</a> &nbsp;&bull;&nbsp; &copy; FelipePDS</p>
 
