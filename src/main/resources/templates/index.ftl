<!DOCTYPE html>
<html class="no-js" lang="">

<head>
    <meta charset="utf-8">
    <title></title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="manifest" href="site.webmanifest">
    <link rel="apple-touch-icon" href="icon.png">
    <!-- Place favicon.ico in the root directory -->
    <link rel="stylesheet" href="css/normalize.css">
    <link rel="stylesheet" href="css/main.css">
    <link href="https://fonts.googleapis.com/css?family=Rubik:400,500&display=swap" rel="stylesheet">


    <meta name="theme-color" content="#fafafa">
</head>

<body>
<!--[if IE]>
<p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="https://browsehappy.com/">upgrade
    your browser</a> to improve your experience and security.</p>
<![endif]-->

<!-- Add your site or application content here -->
<div class="block conference">
    <div class="container">

        <h1>Less Cooler than GeeCon Conf</h1>
        <h2>V${version} <img src=".png" width="7%"/></h2>
        Auto Refresh: <a href="#" onclick="refreshOn()">On</a> / <a href="#" onclick="refreshOff()">Off</a>
    </div>
</div>
<div class="bottom-blocks">
    <div class="block block-left">
        <div class="container">
            <h2>${c4p}</h2>

            <h4>New Proposal</h4>

            <label>Title</label>
            <input id="title" type="text">
            <label>Author</label>
            <input id="author" type="text">
            <label>Email</label>
            <input id="email" type="text">
            <label>Abstract</label>
            <textarea id="description"></textarea>
            <a href="#" onclick="submitProposal()">Submit</a>

            <h4>Proposal Received</h4>

            <ul>
                <li>proposal title - author - pending - <a href="#" onclick="approveProposal()">accept</a> / <a href="#" onclick="rejectProposal()">reject</a></li>
                <li>proposal title - author - pending - <a href="#" onclick="approveProposal()">accept</a> / <a href="#" onclick="rejectProposal()">reject</a></li>
                <li>proposal title - author - pending - <a href="#" onclick="approveProposal()">accept</a> / <a href="#" onclick="rejectProposal()">reject</a></li>
            </ul>
        </div>
    </div>
    <div class="block block-right">
        <div class="container">
            <h2>${agenda}</h2>

            <h4>Accepted Talks</h4>
            <#list agendaItems as item>
                <ul>
                    <li>${item.author} -> ${item.title} @ ${item.talkTime?string('dd.MM.yyyy HH:mm:ss')}</li>
                </ul>
            </#list>
        </div>
    </div>
</div>
<script src="js/vendor/modernizr-3.7.1.min.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"
        integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
<script>window.jQuery || document.write('<script src="js/vendor/jquery-3.4.1.min.js"><\/script>')</script>
<script src="js/plugins.js"></script>
<script src="js/main.js"></script>
<script type="text/javascript">
    // $(document).ready(function () {
    //     setInterval(function () {
    //         window.location = window.location;
    //     }, 3000);
    // });

    function refreshOn(){
        // setInterval(function () {
        //     window.location = window.location;
        // }, 3000);
    }

    function refreshOff(){
        
    }

    function approveProposal(){
        console.log("approving");
    }

    function rejectProposal(){
        console.log("rejecting");

    }

    function submitProposal() {
        var xhr = new XMLHttpRequest();
        xhr.open("POST", "${c4pURL}", true);
        xhr.setRequestHeader('Content-Type', 'application/json');
        var data = JSON.stringify({
            author: document.getElementById("author").value,
            email: document.getElementById("email").value,
            title: document.getElementById("title").value,
            description: document.getElementById("description").value
        });
        console.log(data);
        xhr.send(data);
        window.location = window.location;
    }
</script>


</body>

</html>