<%@ taglib prefix='security' uri='http://www.springframework.org/security/tags' %>
   <div id="header-container">
      <div id="logo">
         <h1>
            <a href="#" onclick="window.open('about.html','AboutWin','toolbar=no, menubar=no,location=no,resizable=no,scrollbars=yes,statusbar=no,top=100,left=200,height=650,width=450');return false"><img alt="VGML Header" src="img/vgml-banner.png"></a>
         </h1>
      </div>
      <div id="menu">
         <ul >
            <security:authorize ifAllGranted="ROLE_ADMINISTRATOR">
                <li ><a href="admin.html">Administration<span></span></a></li>
            </security:authorize>

            <li <%if (request.getRequestURL().toString().contains("/joblist.jsp")) {%>class="current" <%} %>><a href="joblist.html">Manage Jobs<span></span></a></li>
            <li <%if (request.getRequestURL().toString().contains("/jobbuilder.jsp")) {%>class="current" <%} %>><a href="jobbuilder.html">Submit Job<span></span></a></li>

            <security:authorize ifAllGranted="ROLE_ANONYMOUS">
                <li><a href="login.html">Login<span></span></a></li>
            </security:authorize>

            <security:authorize ifNotGranted="ROLE_ANONYMOUS">
                <li ><a href="j_spring_security_logout">Logout<span></span></a></li>
            </security:authorize>
         </ul>
      </div>
      <span id="latlng" class="input-text"></span>

      <%if (request.getRequestURL().toString().contains("/gmap.jsp")) {%>
          <div id="permalinkicon"><a href="javascript:void(0)"><img src="img/link.png" width="16" height="16"/></a></div>
          <div id="permalink"><a href="javascript:void(0)">Permanent Link</a></div>
      <%} %>
   </div>
