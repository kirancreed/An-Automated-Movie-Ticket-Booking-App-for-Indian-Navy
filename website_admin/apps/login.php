<!DOCTYPE html>
<html>
<head>
  
<title>Navy welfare</title>
    <link rel="icon" type="image/x-icon" href="../../images/favicon.ico">
   
  <style>
    .body {
      background: linear-gradient(144deg, #0a555f, #3f838f 50%, #93dbe0);
      margin: 0;
      padding: 0;
      height: 100%; /* Use the full height of the viewport */
     
                              
    }

    .container {
      display: flex;
      justify-content: center;
      align-items: center;
      height: 70vh; /* Use the full height of the viewport */
    }



    .login {
      width: 340px;
      height: 400px;
      background: #d3dadf;
      padding: 47px;
      padding-bottom: 57px;
      color: #fff;
      border-radius: 17px;
      padding-bottom: 50px;
      font-size: 1.3em;
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
      position: relative; /* Position relative for parent container */
    }

    .login input[type="text"],
    .login input[type="password"] {
      opacity: 1;
      display: block;
      border: none;
      outline: none;
      width: 100%;
      padding: 13px 18px;
      margin: 20px 0 0 0;
      font-size: 0.8em;
      border-radius: 100px;
      background: #98beca;
      color: #fff;
      width: 300px;
    }

    .login input:focus {
      animation: bounce 1s;
      webkit-appearance: none;
    }

    .login input[type=submit],
    .login input[type=button],
    .h1 {
      border: 0;
      color: #000;
      outline: 0;
      width: 100%;
      padding: 13px;
      margin: 40px 0 0 0;
      border-radius: 500px;
      font-weight: 600;
      animation: bounce2 1.6s;
    }

    .h1 {
      padding: 0;
      position: relative;
      top: -35px;
      display: block;
      margin-bottom: -0px;
      font-size: 1.3em;
    }

    .btn {
      background: linear-gradient(144deg, #075e61, #3a88a0 50%, #38e2ee);
      color: #fff;
      padding: 16px !important;
    }

    .btn:hover {
      background: linear-gradient(144deg, #edf0f1 , 20%,#7d9299 50%,#32464b );
      color: rgb(255, 255, 255);
      padding: 16px !important;
      cursor: pointer;
      transition: all 0.4s ease;
    }

    .login input[type=text] {
      animation: bounce 1s;
      -webkit-appearance: none;
    }

    .login input[type=password] {
      animation: bounce1 1.3s;
    }

    .ui {
      font-weight: bolder;
      background: -webkit-linear-gradient(#B563FF, #535EFC, #0EC8EE);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      border-bottom: 4px solid transparent;
      border-image: linear-gradient(0.25turn, #535EFC, #0EC8EE, #0EC8EE);
      border-image-slice: 1;
      display: inline;
    }

    @media only screen and (max-width: 600px) {
      .login {
        width: 70%;
        padding: 3em;
      }
    }

    @keyframes bounce {
      0% {
        transform: translateY(-250px);
        opacity: 0;
      }
    }

    @keyframes bounce1 {
      0% {
        opacity: 0;
      }

      40% {
        transform: translateY(-100px);
        opacity: 0;
      }
    }

    @keyframes bounce2 {
      0% {
        opacity: 0;
      }

      70% {
        transform: translateY(-20px);
        opacity: 0;
      }
    }

    /* Add new styles for the toggle button */
    .toggle-password,
    .toggle-password-2 {
      background: none;
      border: none;
      position: absolute;
      right: 15%;
      top: 47%;
      transform: translateY(-50%);
      cursor: pointer;
      padding: 5px;
      z-index: 10;
      width: 30px; /* Set width */
      height: 30px; /* Set height */
    }

    .toggle-password img,
    .toggle-password-2 img {
      width: 100%;
    }

    /* Hide the second toggle button initially */
    .toggle-password-2 {
      display: none;
    }
.logo{
  color: #fff;
    padding: 10px 10px;
    text-align: center;
    margin-bottom: 0px;
    border-radius: 15px;
    max-width: 100%; /* Adjust the max width for responsiveness */
    width: auto; /* Adjusts with the container */

}
    

  </style>
</head>
<body class="body">
<div class="logo">
					
					<h1>Navy Welfare</h1>
  </div>        

<div class="container">
  <div class="login wrap">
    
    
  <div class="h1" align="center">LOGIN</div>
   

  <form action="login_handler.php" method="post">
    <input pattern="^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$" placeholder="Email" id="email" name="email" type="text">
    <div style="position:relative;">
      <input placeholder="Password" id="password" name="password" type="password">

          </div>
          
  <button type="button" class="toggle-password" onclick="togglePasswordVisibility()">
        <img src="padlock.png" alt="Toggle password visibility">
      
</button>
      <button type="button" class="toggle-password-2" onclick="togglePasswordVisibility()">
        <img src="unlock.png" alt="Toggle password visibility">
      </button>
   <!-- <a href="login_handler.php"> -->
     <input value="Login" class="btn" type="submit">
     </form>
      
  </div>
</div>

<script>
function togglePasswordVisibility() {
  var passwordField = document.getElementById("password");
  var toggleButton1 = document.querySelector(".toggle-password");
  var toggleButton2 = document.querySelector(".toggle-password-2");
  
  if (passwordField.type === "password") {
    passwordField.type = "text";
    toggleButton1.style.display = "none";
    toggleButton2.style.display = "block";
  } else {
    passwordField.type = "password";
    toggleButton1.style.display = "block";
    toggleButton2.style.display = "none";
  }
}
</script>

</body>
</html>
