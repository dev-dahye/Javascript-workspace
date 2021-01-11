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
			const request = new XMLHttpRequest();
			request.onreadystatechange = () =>{
				console.log("응답", request.readyState);
			};
			// 비동기방식
			request.open('GET', './data/data.csv', true);
			request.send();
			
			// 데이터 응답이 오기전에 먼저 처리해버린다. 
			const data = request.responseText.trim();
			const rowdata = data.split('\n');
			
			let result = '<table border="1">';
			for(let i=0; i<rowdata.length; i++){
				let coldata = rowdata[i].split(",");
				result += '<tr>';
				result += '<td>'+ coldata[0] +'</td>';
				result += '<td>'+ coldata[1] +'</td>';
				result += '<td>'+ coldata[2] +'</td>';
				result += '<td>'+ coldata[3] +'</td>';
				result += '</tr>';
			}
			result += '</table>';
			
			document.getElementById('result').innerHTML = result;
		};
	};
</script>
</head>
<body>

<button id="btn">요청하기</button>
<div id="result"></div>

</body>
</html>