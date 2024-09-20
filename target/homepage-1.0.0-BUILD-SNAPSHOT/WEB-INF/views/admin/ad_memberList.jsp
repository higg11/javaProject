<%@page import="com.team.domain.MemberDTO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%   
   ArrayList<MemberDTO> memberList= (ArrayList<MemberDTO>)request.getAttribute("list");
%>    

<%@ include file="../include/ad_header.jsp" %>                                                                                                     

<div class='container mt-3'>                                                                                
  <h2>회원 리스트</h2>                                                                                      
  <table class='table'>                                                                                     
    <thead class='table-dark'>                                                                              
      <tr>                                                                                                  
        <th>번호</th>                                                                                       
        <th>아이디</th>                                                                                     
        <th>비밀번호</th>                                                                                   
        <th>이름</th>                                                                                       
        <th>이메일</th>                                                                                     
        <th>전화번호</th>                                                                                   
        <th>포인트</th>                                                                                   
        <th>삭제</th>                                                                                       
      </tr>                                                                                                 
    </thead>                                                                                                
    <tbody>                                                                                                 

<% for(MemberDTO dto : memberList) { %>
   <tr>                                                                                                 
     <td><%=dto.getId() %></td>                                                                           
     <td><a href='memberInfo.do?id=<%=dto.getId()%>'><%=dto.getId()%></a></td>              
                 
     <td><%=dto.getPw()%></td>                                                                           
     <td><%=dto.getName()%></td>                                                                         
     <td><%=dto.getEmail()%></td>                                                                        
     <td><%=dto.getTel()%></td>                                                                          
     <td><%=dto.getPoint()%></td>                                                                          
     <td><input type="button" class='btn btn-danger btn-sm' 
           value="삭제" onclick="delMember(<%=dto.getId()%>)"/></td>                                                                 
   </tr>                                                                                                
<%}%>

	<!----------------------------- Ajax 리스트 START --------------------------->
	<tr>
		<td colspan="8">
			<input type="button" value="Ajax회원리스트" class="btn btn-secondary" onclick="showList()"/>
		</td>
	</tr>
	<tr>
		<td colspan="8" id="ajaxList">			
		</td>
	</tr>

	<!------------------------------------------------------------------------->
                                                                                           
    </tbody>                                                                                              
  </table>                                                                                                
</div>

<script src="https://code.jquery.com/jquery-3.4.1.js"></script>   
<script>  
	function showList(){
		$.ajax({
			url:"<c:url value='memberAjaxList.do'/>",  // 요청주소 
			type:"get",  // 전송방식
			dataType:"json",  // 서서버에서 응답하는 데이터 형식
			success: resultList,  // 서버에서 성공적으로 요청이 수행되었을 경우 호출되는 함수
			error: function(){alert("error")}  // 서버에서 요청처리를 실패했을 때 처리되는 함수
		});
	}
	
	function resultList(data){  // data는 서버에서 응답한 데이터(json), data는 매개변수로 아무거나 써도된다.
		console.log(data);
		let html= "<table class='table'>";                                                                                     
        html+="   <thead class='table-dark'>  ";                                                                            
        html+="     <tr>                      ";                                                                            
        html+="       <th>번호</th>           ";                                                                            
        html+="       <th>아이디</th>         ";                                                                            
        html+="       <th>비밀번호</th>       ";                                                                            
        html+="       <th>이름</th>           ";                                                                            
        html+="       <th>이메일</th>         ";                                                                            
        html+="       <th>전화번호</th>       ";                                
        html+="       <th>포인트</th>       ";                                
        html+="     </tr>                     ";                                                                            
        html+="   </thead>                    ";                                                                            
        html+="   <tbody>                     ";
       
        $.each(data, function(index, obj){  // index로 data에 있는 각 obj를 하나씩 꺼내옴
	        html+="<tr>";
	        html+="<td>"+obj.no+"</td>";   
	        html+="<td>"+obj.id+"</td>";   
	        html+="<td>"+obj.pw+"</td>";   
	        html+="<td>"+obj.name+"</td>";   
	        html+="<td>"+obj.email+"</td>";   
	        html+="<td>"+obj.tel+"</td>";
	        html+="<td>"+obj.point+"</td>";
	        html+="</tr>";
        });
	        html+="</tbody>";
	        html+="</table>";
	        
        $("#ajaxList").html(html);
	}

	function delMember(id){      
      location.href="memberDelete.do?id="+id;
   }
</script>

<%@ include file="../include/ad_footer.jsp" %>                                                                            