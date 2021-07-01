<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>	

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<script src="https://unpkg.com/boxicons@latest/dist/boxicons.js"></script>
<link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css'
	rel='stylesheet'>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/index.css" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.3.2/chart.min.js"
	integrity="sha512-VCHVc5miKoln972iJPvkQrUYYq7XpxXzvqNfiul1H4aZDwGBGC0lq373KNleaB2LpnC2a/iNfE5zoRYmB4TRDQ=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"
	integrity="sha512-qTXRIMyZIFb8iQcfjXWCO8+M5Tbc38Qi5WzdPOYZHIlZpzBHG3L3by84BBBOiRGiEb7KKtAOAs5qYdUiZiQNNQ=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/locale/ko.min.js"
	integrity="sha512-3kMAxw/DoCOkS6yQGfQsRY1FWknTEzdiz8DOwWoqf+eGRN45AmjS2Lggql50nCe9Q6m5su5dDZylflBY2YjABQ=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/paginationjs/2.1.5/pagination.min.js"
	integrity="sha512-1zzZ0ynR2KXnFskJ1C2s+7TIEewmkB2y+5o/+ahF7mwNj9n3PnzARpqalvtjSbUETwx6yuxP5AJXZCpnjEJkQw=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/paginationjs/2.1.5/pagination.css"
	integrity="sha512-QmxybGIvkSI8+CGxkt5JAcGOKIzHDqBMs/hdemwisj4EeGLMXxCm9h8YgoCwIvndnuN1NdZxT4pdsesLXSaKaA=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<sec:authentication property="principal" var="principal"/>
<div class="container">
	<div class="row justify-content-center">
		<div class="col-12">

			<div class="card shadow mb-4">
				<div class="card-header py-3">
					<h6 class="m-0 font-weight-bold text-primary">출퇴근 신청</h6>
				</div>
				<div class="card-body">
					<div class="chart-bar">
						<div id="now"></div>
						<button type="button" class="btn btn-primary" id="start-work"
							onclick="startWork(${principal.empNo});">출근</button>
						<button type="button" class="btn btn-secondary" id="end-work"
							onclick="endWork(${principal.empNo})" disabled>퇴근</button>

					</div>
				</div>
			</div>
		</div>
	</div>


	<!-- Content Row -->
	<div class="row justify-content-center">

		<div class="col-xl-8">
			<!-- Area Chart -->
			<div class="card shadow mb-4">
				<div class="card-header py-3">
					<h6 class="m-0 font-weight-bold text-primary">주간 근무시간</h6>
				</div>
				<div class="card-body">
					<div id="week" class="d-flex justify-content-center"></div>
					<div class="chart-area" style="max-height:240px;">
						<canvas id="mybarChart" style="max-height:210px;"></canvas>
					</div>
					<!-- <hr> -->
				</div>
			</div>
		</div>
		<!-- Donut Chart -->
		<div class="col-xl-4">
			<div class="card shadow mb-4">
				<!-- Card Header - Dropdown -->
				<div class="card-header py-3">
					<h6 class="m-0 font-weight-bold text-primary">총 근무시간</h6>
				</div>
				<!-- Card Body -->
				<div class="card-body ">
					<div class="chart-pie pt-4" style="width: 250px; max-height:240px; margin: 0 auto;">
						<canvas id="myPieChart" style="max-height:210px;"></canvas>
					</div>
					<!-- <hr> -->
				</div>
			</div>

		</div>
	</div>
	<div class="row justify-content-center">
		<div class="col-12">
			
			<div class="card shadow mb-4">
				<div class="card-header py-3">
					<h6 class="m-0 font-weight-bold text-primary">근무 내역</h6>
				</div>
				<div class="card-body">
					<div class="chart-bar">
					<div class="input-group mb-3">
					<input type="text" id="search" class="form-control"
									placeholder="월/일 형식으로 검색" aria-label=""
									aria-describedby="basic-addon2">
									<button class="btn btn-primary" onclick="searchTable(${principal.empNo})">검색</button>
						</div>
				<table class="table table-bordered" id="dataTable"
					cellspacing="0">
				</table>
					</div>
					<div class="mb-3" style="margin: 0 auto;">
				<div class="d-flex justify-content-center ">
					<div id="pagination-container"></div>
				</div>
			</div>
				</div>
			</div>
		</div>
	</div>
	<!-- DataTales Example -->
	

</div>

<script>
const now = () => {
	const time = moment().format('YYYY MMMM Do a h:mm:ss ');
	let html = `<h5>\${time}</h5>`
	$("#now").html(html)
}

setInterval(now, 1000);

const startWork = (empNo) => {
	confirm("근무를 시작하시겠습니까?");
	$.ajax({
		url:`${pageContext.request.contextPath}/attendance/startWork/\${empNo}`,
		method:'GET',
		success(data){
			$("#start-work").attr("disabled", true);
			$("#end-work").attr("disabled", false);
		},
		error:console.log

	})

}

const endWork = (empNo) => {
	confirm("근무를 종료하시겠습니까?");
	$.ajax({
		url:`${pageContext.request.contextPath}/attendance/endWork/\${empNo}`,
		method:'GET',
		success(data){
			$("#start-work").attr("disabled", false);
			$("#end-work").attr("disabled", true);
		},
		error:console.log

	})
};

function simpleTemplating(data) {
    var html = `<table class="table table-bordered">
       			 <thead>
					<tr>
						<th>시작시간</th>
						<th>종료시간</th>
						<th>근무시간</th>

					</tr>
				</thead>
				<tbody>`;
    $.each(data, function(index, item){
      
        const end =  moment(item.attEnd)
    	const start =  moment(item.attStart)
    	
        const attStart = start.format("MMM Do HH:mm");
        const attEnd = end.format("MMM Do HH:mm");
    
    	const diff = moment.duration(end.diff(start))
    	const hour = diff.hours();
    	const minutes = diff.minutes();
    	console.log(hour, minutes.toString().length)
    	const min = minutes.toString().length == 1 ? 0+minutes.toString(): minutes.toString();
	
        html += `<tr>
            		<td>\${attStart}</td>
					<td>\${attEnd}</td>
					<td>\${hour}:\${min}</td>
            	</tr>`;
    });
    html += '</tbody></table>';
    return html;
}

const searchTable = (empNo) =>{
	const search = $("#search").val()
	console.log(search)
	workTable(empNo, search);
}

const workTable = (empNo, search) => {
	console.log(search)
	$.ajax({
		url:`${pageContext.request.contextPath}/attendance/workTable`,
		method:'GET',
		data: {empNo, search},
		success(data){
			console.log(data);
			
			$('#pagination-container').pagination({
			    dataSource: data,
			    callback: function(data, pagination) {
			        var html = simpleTemplating(data);
			        $('#dataTable').html(html);
			    }
			})
						
			
		},
		error:console.log

	})
};
var myBarChart;
var myPieChart;
let startOfWeek = moment().startOf('week')
let endOfWeek = moment().endOf('week')
console.log(startOfWeek.format("MMDD"))
console.log(endOfWeek.format("MMDD"))

const week = (startOfWeek, endOfWeek) => {

	const sow = startOfWeek.format("MMM Do");
	const eow = endOfWeek.format("MMM Do");
	const month = moment().format("MMM");

	const html = `<box-icon type='solid' name='chevron-left' onclick="goLeft()"></box-icon>
					<h6>
					\${sow} ~ \${eow}
				  </h6>
				  <box-icon name='chevron-right' type='solid' onclick="goRight()"></box-icon>`;
	$("#week").html(html)
}


const goLeft = () => {
	myBarChart.destroy();
	myPieChart.destroy();
	startOfWeek = startOfWeek.subtract(7, 'days');
	endOfWeek = endOfWeek.subtract(7, 'days');
	console.log(startOfWeek.format("MMDD"));
	workHour(${principal.empNo},startOfWeek, endOfWeek);
	weekTotalWorkHour(${principal.empNo}, startOfWeek, endOfWeek);
	week(startOfWeek, endOfWeek)
	
}

const goRight = () => {
	myBarChart.destroy();
	myPieChart.destroy();
	startOfWeek = startOfWeek.add(7, 'days');
	endOfWeek = endOfWeek.add(7, 'days');
	workHour(${principal.empNo},startOfWeek, endOfWeek);
	weekTotalWorkHour(${principal.empNo}, startOfWeek, endOfWeek);
	week(startOfWeek, endOfWeek)
}


const workHour = (empNo, startOfWeek, endOfWeek) => {

	startOfWeek = startOfWeek.format("MMDD")
	endOfWeek = endOfWeek.format("MMDD")
	$.ajax({
		url:`${pageContext.request.contextPath}/attendance/workHour`,
		method:'GET',
		data: {empNo, startOfWeek, endOfWeek},
		success(result){
			console.log(result)
			
			const N = 7;
			let dayArr = [];
			//(dayArr=[]).length = 7;
			//dayArr.fill(0)
			const hourArr = [];
			$.each(result, (index, item) => {
				dayArr.push(moment(item.attStart).format("Do dd"))
				hourArr.push(item.workHour)
			})
			console.log(dayArr)
			const labels = dayArr;
			const data = {
				labels : labels,
				datasets : [ {
					label : '근무시간',
					data : hourArr,
					backgroundColor : [ 'rgba(255, 99, 132, 0.8)',
							'rgba(255, 159, 64, 0.8)', 'rgba(255, 205, 86, 0.8)',
							'rgba(75, 192, 192, 0.8)', 'rgba(54, 162, 235, 0.8)',
							'rgba(153, 102, 255, 0.8)', 'rgba(201, 203, 207,0.8)' ],
					borderColor : [ 'rgb(255, 99, 132)', 'rgb(255, 159, 64)',
							'rgb(255, 205, 86)', 'rgb(75, 192, 192)',
							'rgb(54, 162, 235)', 'rgb(153, 102, 255)',
							'rgb(201, 203, 207)' ],
					borderWidth : 1
				} ]
			};

			const config = {
				type : 'bar',
				data : data,
				options : {
					responsive: true,
					aspectRatio :4,
					plugins:{
						legend : {
							display:false,
						},
					},
					scales : {
						y : {
							beginAtZero: true,
							grid : {
								display : false,
							}
						},
						x:{
							grid : {
								display : false,
							}
						}

					},

				},
			};

			const ctx = $("#mybarChart");
			myBarChart = new Chart(
					ctx, 
					config
				);


		},
		error:console.log

	})
}


const weekTotalWorkHour = (empNo, startOfWeek, endOfWeek) => {

	startOfWeek = startOfWeek.format("MMDD")
	endOfWeek = endOfWeek.format("MMDD")
	
	$.ajax({
		url:`${pageContext.request.contextPath}/attendance/workHour`,
		method:'GET',
		data: {empNo, startOfWeek, endOfWeek},
		success(result){
			console.log(result)
			let sum = 0;
			$.each(result, (index, item) =>{
				sum += item.workHour;
				console.log(sum)
			})
		
			const hour = moment(sum);
			
			console.log(hour)
	

			const data = {
					  labels: ['근무시간', '잔여 근무시간'],
					  datasets: [
					    {
					      label: 'Dataset 1',
					      data: [sum, 52-sum],
					      backgroundColor: [
						      'rgb(255, 99, 132)',
						      'rgb(54, 162, 235)',
						      'rgb(255, 205, 86)',
						      'rgb(255, 205, 86)'
						    ],
					    }
					  ]
					};

			const config = {
					  type: 'doughnut',
					  data: data, 
					  options: {
					    responsive: true,
					    plugins: {
					      legend: {
					        position: 'top',
					      },
					      title: {
					        display: false,
					      }
					    }
					  },
					};

			const ctx = $("#myPieChart");
			myPieChart = new Chart(
					ctx, 
					config
				);


		},
		error:console.log

	})
}



week(startOfWeek, endOfWeek);
workHour(${principal.empNo}, startOfWeek, endOfWeek);
workTable(${principal.empNo}, '');	
weekTotalWorkHour(${principal.empNo}, startOfWeek, endOfWeek);
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />