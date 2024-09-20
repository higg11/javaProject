/**
 *  23-11-01 javascript file -> *.js
 */

// 전체선택
function checkAll(){
	// 위에 전체선택 체크박스 : 체크되었으면 true, 아니면 false 값을 리턴함 // getElement - Id는 하나만 가능
	let isChecked = document.getElementById("checkAll").checked;
	
	// 밑에 체크박스 : 체크되었으면 true, 아니면 false 값을 리턴함 // getElements - Name은 여러개 가능
	let chks = document.getElementsByName("chk");
	
	// isChecked 가 true(체크)이면 체크 속성값에 밑에 chks체크들이 다 체크되게 함
	for(let i=0; i<chks.length; i++){
		chks[i].checked = isChecked;
	}
}

// 선택항목 삭제
function prodDel(){	  	// *** 구분자가 아닌 배열로도 넘길 수 있음, 넘기는 방법은 여러가지
	let chks = document.getElementsByName("chk");	// 체크된거 수집
	let pnumStr = "";								// 문자열에 수집
	let separator = false;							// 구분자 설정
	
	for(let i=0; i<chks.length; i++){
		if(chks[i].checked){		// 체크된 체크박스가 있다면
			if(separator){	// 최초에는 구분자가 수행안됌 = 최초는 false이기 때문에
				pnumStr = pnumStr + "/";	// separator = true;일 경우 구분자 설정
			}
			pnumStr = pnumStr + chks[i].value;	// 삭제된 체크박스의 번호들을 문자열에 수집 3/5/6/12/...
			//console.log(pnum);  // 체크된거의 번호를 출력 --> 3
			separator = true;		// 구분자 true로 바꿔줌 (다음 문자열에 구분자 넣을 수 있음)
		}
	}
	if(!pnumStr){		// pnumStr null이면(삭제체크박스에 체크가 안되어 있으면)
		alert("삭제할 상품을 체크하세요!!");
		return;
	}
	
	console.log(pnumStr);  // 체크된거의 번호를 출력 --> 3/5/6/12/...
	// 삭제할 상품번호문자열 pnumStr을 input태크 delPnums에 저장하면 됌
	document.checkForm.delPnums.value=pnumStr;
	
	let res = confirm("정말 삭제 하시겠습니까?"); // ok(확인, 예)를 누르면 리턴값이 true
	if(res){		// res가 true 이면
		//action="cartDelete.do"로 pnumStr -> delPnums 값을보냄
		document.checkForm.submit();
	}
} //function

// 포인트 사용
function usePoint(obj, point, price){
	let pointElem = document.getElementById("point");
	let tot_amount = document.getElementById("cartTotPrice");
	
	if(obj.checked) { //obj-체크박스가 참일때
						// 현재포인트를 넣어준다. // 정규표현식을 이용해서 천단위로 변경해주겠다. 	
		pointElem.value = point.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");	
		tot_amount.innerText = (price - point).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	} else {		//obj-체크박스가 거짓일때		// .replace(/\B(?=(\d{3})+(?!\d))/g) 숫자 세자리씩 끊어서 콤마로 표현하겠다
		pointElem.value = "";
		tot_amount.innerText = price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
}

// 문자 입력방지(숫자만 입력)
function removeChar(e){		// 0-9숫자가 ^아닌 /g대소문자 구분없이 다른값이 들어왔을때 빈값으로 처리
	e.target.value = e.target.value.replace(/[^0-9]/g, '');
}

// 지불방법 선택
function selPayment(){ //document 가져온 문서의 name="payment"
	let payArr = document.getElementsByName("payment");
	
	for(let i=0; i<payArr.length; i++){
		if(payArr[i].checked){ // 체크가 되어있으면 참 // value="card" value="rTransfer" value="deposit" value="hp"
			document.getElementById(payArr[i].value).style.display="block"; // value값을 가져와서 디스플레이 스타일을 block으로 바꿔준다 
		} else {															// style="display:none"
			document.getElementById(payArr[i].value).style.display="none"; // 나머지는 none으로 바꿔준다 
		}
	}
}




