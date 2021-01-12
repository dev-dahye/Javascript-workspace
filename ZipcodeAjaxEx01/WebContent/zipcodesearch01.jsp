<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	window.onload = () => {
		document.getElementById('btn').onclick = () => {			
			const strDong = document.getElementById('dong').value.trim();
			
			// 입력값 검사
			if( strDong == '' ) {
				alert( '동이름을 입력해 주세요' );
				return;
			}
			if( strDong.length == 1 ) {
				alert( '두글자 이상 입력해 주세요' );
				return;
			}
			
		
			let result = "<table width='800' border='1'>";
			result += "<tr>";
			result += "<td>우편번호</td><td>시도</td><td>구군</td><td>동</td><td>리</td><td>번지</td>";
			result += "</tr>";
		
			const request = new XMLHttpRequest();
			request.onreadystatechange = () =>{
				if(request.readyState == 4){
					if(request.status == 200){
						//const data = request.responseText.trim();
						//console.log(data);
						
						const xmlData = request.responseXML;
						
						//const seqs = xmlData.getElementsByTagName('seq');
						const zipcodes = xmlData.getElementsByTagName('zipcode');
						const sidos = xmlData.getElementsByTagName('sido');
						const guguns = xmlData.getElementsByTagName('gugun');
						const dongs = xmlData.getElementsByTagName('dong');
						const ris = xmlData.getElementsByTagName('ri');
						const bunjis = xmlData.getElementsByTagName('bunji');
											
						for(let i=0; i<zipcodes.length; i++){
							//let seqValue = seqs[i].childNodes[0].nodeValue;
							let zipcodeValue = zipcodes[i].childNodes[0].nodeValue;
							let sidoValue = sidos[i].childNodes[0].nodeValue;
							let gugunValue = guguns[i].childNodes[0].nodeValue;
							let dongValue = dongs[i].childNodes[0].nodeValue;
							//let riValue = ris[i].childNodes[0].nodeValue=='.'?"":ris[i].childNodes[0].nodeValue;
							//let bunjiValue = bunjis[i].childNodes[0].nodeValue=='.'?"":bunjis[i].childNodes[0].nodeValue;
							
							// 데이터가 없는 처리 하는 방법
							let riValue = ""
							if(ris[i].childNodes[0] != null){
								riValue = ris[i].childNodes[0].nodeValue;
							}
							
							let bunjiValue = "";
							if(bunjis[i].childNodes[0] != null){
								bunjiValue = bunjis[i].childNodes[0].nodeValue;
							}
						
							
							result += "<tr>";
							//result += "<td>"+seqValue+"</td>";
							result += "<td>"+zipcodeValue+"</td>";
							result += "<td>"+sidoValue+"</td>";
							result += "<td>"+gugunValue+"</td>";
							result += "<td>"+dongValue+"</td>";
							result += "<td>"+riValue+"</td>";
							result += "<td>"+bunjiValue+"</td>";
							result += "<tr>";
						}
						
						result += "</table>";
						
						document.getElementById('result').innerHTML = result;
						
					} else{
						alert('에러페이지')
					}
				}
			};
			request.open('GET', './data/xml.jsp?strDong=' + strDong, true);
			request.send();
		};
	};
</script>
</head>
<body>

<form name="frm" >
동이름<input type="text" id="dong" size="30" />
<input type="button" id="btn" value="우편번호 찾기" />
</form>
<hr /><br />

<div id="result"></div>

</body>
</html>