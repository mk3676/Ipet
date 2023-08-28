<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
        /* CSS for the sidebar */
        .sidebar {
            position: fixed;
            top: 50%;
            left: 30px;
            transform: translateY(-50%);
            background-color: #cfe2f3;
            width: 200px;
            padding: 10px;
            overflow-y: auto;
            border-radius: 10px;
            border-right: 1px solid #dee2e6;
            border: 2px solid #007bff;
        }

        .sidebar ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .sidebar li {
            margin-bottom: 10px;
            text-align: center;
        }

        .sidebar li a {
            text-decoration: none;
        }

        /* CSS for the main section */
        .main-section {
            margin-left: 220px; /* Adjust the margin to accommodate the sidebar width */
        }

        /* CSS for the rest of the page */
        body {
            margin: 0;
            padding: 0;
        }
    </style>
 <div class="sidebar">
	<h3 style="text-align: center;">카테고리</h3>
	<ul class="links">
		<li ><a href="/products/food" >사료/간식</a></li>
		<li><a href="/products/pad">패드/장난감</a></li>
		<li><a href="/products/bath">목욕/하네스</a></li>
	</ul>
</div>										