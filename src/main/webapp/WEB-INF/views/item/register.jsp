<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../include/header2.jsp"  %>
	<section id="section">
   		<h1>상품등록</h1>	
	</section>

   <section id="section">
   <form name="itemForm" id="itemForm" action="/item/register" method="post" enctype="multipart/form-data">
      <table>
         <tr>
            <th>
               <label for="itemName">상품명</label>
            </th>   
         </tr>
         <tr>
            <th>
               <input type="text" class="form-control" id="itemName" name="itemName">
             </th>
         </tr>
          <tr>
            <th>
               <label for="itemName">상품설명</label>
            </th>   
         </tr>
         <tr>
            <td>
               <textarea class="itemContent" name="itemContent" id="itemContent" rows="15" cols="75" placeholder="상품에 대한 설명"
                maxlength="500" style="resize: none; text-indent:5px;"></textarea>
             </td>
         </tr>
         <tr>
<!--          <td class="file_load">
            <p>최대 5개의 이미지(.gif, .jpg, .png) 파일이 등록 가능합니다.</p>
            <input type="hidden" id="load_cnt" value="1">
            <button type="button" id="fileBtn">첨부 추가</button><br>
            파일 선택 : <input type="file" name="files" accept="image/*"><br>
         </td>  -->

<!--             <td class="file_load">
               파일 선택 : <input type="file" name="files" id="inputFile" multiple="multiple" accept="image/*" >
            </td>  -->
         </tr>
         
         <tr>
<!--             <td colspan="5">
               <div class="previewBox">
                  <img id="img" />

               파일 선택 : <input type="file" name="files" accept="image/*" ><br>
            </td> -->


            <tr>
	
			  <td colspan="2" class="file_load">
			    <label for="inputFile" class="fileButton">파일 선택</label>
			    <input type="file" name="files" id="inputFile" multiple="multiple" accept="image/*" style="display: none;">
			  </td>
			</tr>
         
	         <tr>
	            <td colspan="5">
	               <div class="previewBox" style="display: none;">
	                  
	               </div>
	            </td>
	         </tr>
	         
      </table>

      <button type="button" class="btn btn-default faqbtn" onclick="fnRegist();">글 등록하기</button>
   
           
      <button type="button" class="btn btn-default itemlistBtn">
         <a href="/item/getList">리스트로 이동</a>
      </button>
           
   </form>
   
   </section>
   
   <script type="text/javascript">
      
   /*-----------------------------------------------------미리보기 관련*/
      // # readURL함수 : 이미지 미리보기 기능
      var sel_files = [] ; 
      
       $(document).ready(function() {
            $("#inputFile").on("change", handleImgsFilesSelect);
        }); 
 
        function handleImgsFilesSelect(e) {
            sel_files.length = 0;
            var files = e.target.files;
            var filesArr = Array.prototype.slice.call(files);
            $(".previewBox").css('display', 'block');
            $(".previewBox").empty();
            
            
            filesArr.forEach(function(f) {
 
                sel_files.push(f);
 
                var reader = new FileReader();
                reader.onload = function(e) {
                   
                   var img_html = "<img style='width:100px; height:150px; margin:0 10px; outline:1px solid black;' src=\"" + e.target.result + "\" />";
                   console.log(e.target.result) ;
                    $(".previewBox").append(img_html);
                    
                }
                reader.readAsDataURL(f);
            });
        }

    /*-----------------------------------------------------미리보기 관련*/

   function fnRegist(){
      let itemName = $("#itemName").val();
      let itemContent = $("#itemContent").val();

      //Regex
      if(itemName == ""  || itemName == null){
         alert("제목 입력은 필수 입니다.");
         return;
      }
      if(itemContent == ""  || itemContent == null){
         alert("내용 입력은 필수 입니다.");
         return;
      }

      let formData = new FormData();
      formData.append('itemName', itemName);
      formData.append('itemContent', itemContent);
      
      for(var i = 0; i<sel_files.length; i++){
         formData.append('files', sel_files[i]);
      }

      $.ajax({
         type : 'POST',
         url : '/item/register',
         data : formData,
         processData : false,
         contentType : false,
         success : function (data){
            let d = $.parseJSON(data);
            if(d.result == 'S'){
               alert('등록 완료!');
               window.location = '/item/getList';
            }
         },
         error : function (){
            alert('관리자에게 문의하라!');
         }
      })
   }

   $(".regBtn").click(function(e){

      });

      $("#fileBtn").click(function(){
         var count = $("#load_cnt").val();
         
         var num = parseInt(count);
         num = num+1;
         
         if(num > 5){
            alert("5개 초과할 수 없습니다.");
            return;
         }
         
         $(".file_load").append('파일 선택 : <input type="file" name="files" accept="image/*"><br>'); 
         num = num+1;
         $("#load_cnt").val(num) ;
       });
      

     

         
   </script> 
   
   
 
   <%@ include file="../include/footer2.jsp"  %>


