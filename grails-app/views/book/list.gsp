<%@ page import="org.grails.example.Book" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="main"/>
  <title>Book List</title>
  <asset:javascript src="fp.js" />
</head>

<body>
<ul class="nav nav-pills">
  <li class="active"><g:link class="list" action="list">Book List</g:link></li>
  <li><g:link class="create" action="create">New Book</g:link></li>
</ul>

<div class="body">
  <h1>Book List</h1>
  <g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
  </g:if>
  <filterpane:currentCriteria domainBean="Book" dateFormat="${[title: 'MM/dd/yyyy', releaseDate: 'MMM dd, yyyy']}"
                              removeImgDir="images" removeImgFile="bullet_delete.png" fullAssociationPathFieldNames="no"
                              filterPropertyValues="${[bookType: [displayProperty: 'display']]}"/>
  <div class="list">
    <table class="table table-bordered">
      <thead>
      <tr>

        <g:sortableColumn property="id" title="Id" params="${filterParams}"/>
        <g:sortableColumn property="title" title="Title" params="${filterParams}"/>
        <g:sortableColumn property="authors" title="Authors" params="${filterParams}"/>
        <g:sortableColumn property="bookType" title="Book Type" params="${filterParams}"/>
        <g:sortableColumn property="readPriority" title="Read Priority" params="${filterParams}"/>
        <g:sortableColumn property="releaseDate" title="Release Date" params="${filterParams}"/>
        <g:sortableColumn property="price" title="Price" params="${filterParams}"/>
        <g:sortableColumn property="pricePlusTax" title="Price Plus Tax" params="${filterParams}"/>
        <g:sortableColumn property="inStock" title="In Stock" params="${filterParams}"/>
        <th>Is Magazine</th>

      </tr>
      </thead>
      <tbody>
      <g:each in="${bookList}" status="i" var="book">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

          <td><g:link action="show" id="${book.id}">${book.id?.encodeAsHTML()}</g:link></td>
          <td>${book.title?.encodeAsHTML()}</td>
          <td><g:each in="${book.authors}" var="author"><span class="label label-info">${author.toString()}</span>&nbsp;</g:each></td>
          <td>${book.bookType.encodeAsHTML()}</td>
          <td>${book.readPriority?.encodeAsHTML()}</td>
          <td><g:formatDate date="${book.releaseDate}" format="MM/dd/yyyy"/></td>
          <td>${book.price?.encodeAsHTML()}</td>
          <td>${book.pricePlusTax?.encodeAsHTML()}</td>
          <td>${book.inStock?.encodeAsHTML()}</td>
          <td>${book.isMagazine?.encodeAsHTML()}</td>

        </tr>
      </g:each>
      </tbody>
    </table>
  </div>

  <div class="paginateButtons">
    <filterpane:paginate total="${bookCount}" domainBean="org.grails.example.Book"/>
    <filterpane:filterButton text="Filter Me" appliedText="Change Filter"/>
    <filterpane:isNotFiltered>Pure and Unfiltered!</filterpane:isNotFiltered>
    <filterpane:isFiltered>Filter Applied!</filterpane:isFiltered>
  </div>
  <filterpane:filterPane domain="org.grails.example.Book"
                         additionalProperties="identifier"
                         associatedProperties="authors.lastName,authors.firstName,authors.age,authors.favoriteGenre,authors.publisher.lastName,bookmarks.page,authors.id"
                         excludeProperties="cost"
                         filterPropertyValues="${[releaseDate: [years: 2015..1950, precision: 'month'], bookType: [displayProperty: 'display'], 'authors.favoriteGenre': [displayProperty: 'display']]}"
                         titleKey="fp.tag.filterPane.titleText"
                         dialog="true"
                         visible="n"
                         showSortPanel="n"
                         showTitle="n"
                         fullAssociationPathFieldNames="false"/>
</div>
</body>
</html>
