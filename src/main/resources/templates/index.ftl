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

        <h1>SouJava Conf</h1>
        <h2>V${version} <img src="soujava.png" width="7%"/></h2>
        <div class="block-options">Auto Refresh: <input onclick="refreshOn()" type="checkbox" name="refresh" value="on">
            <br/>
            ${email}
        </div>

    </div>
</div>
<div class="bottom-blocks">
    <div class="block block-left">
        <div class="container">
            <h2>${c4p}</h2>

            <div class="block-col">
                <h4>New Proposal (Public)</h4>
                <div class="block-form">
                    <div class="form-field">
                        <label>Title</label>
                        <input id="title" type="text">
                    </div>
                    <div class="form-field">
                        <label>Author</label>
                        <input id="author" type="text">
                    </div>
                    <div class="form-field">
                        <label>Email</label>
                        <input id="email" type="text">
                    </div>
                    <div class="form-field">
                        <label>Abstract</label>
                        <textarea id="description"></textarea>
                    </div>
                    <div class="form-actions">
                        <button type="submit" onclick="submitProposal()">Submit</button>
                    </div>
                </div>
            </div>
            <div class="block-col">
                <h4>Proposal Received (Back Office)</h4>
                <#if proposals?? && proposals?has_content>
                    <ul class="item-list">

                        <#list proposals as proposal>
                            <li>
                                <h5 class="item-list__title"><#if proposal.title??>${proposal.title}<#else> N/A</#if></h5>
                                <div class="item-list__author"><#if proposal.description??>${proposal.description}<#else> N/A</#if></div>
                                <div class="item-list__status"><#if proposal.status??>${proposal.status}<#else> N/A</#if>
                                    <#if proposal.status?? && proposal.status == "DECIDED">
                                        <#if proposal.approved>
                                            <span class="item-list__status__approved">ACCEPTED</span>
                                        <#else>
                                            <span class="item-list__status__declined">REJECTED</span>
                                        </#if>
                                    </#if>
                                </div>
                                <#if proposal.status?? && proposal.status == "PENDING">
                                    <div class="item-list__actions">
                                        <a href="#" class="item-list__actions__accept"
                                           onclick="approveProposal('${proposal.id}')">Accept</a>
                                        <a class="item-list__actions__reject" href="#"
                                           onclick="rejectProposal('${proposal.id}')">Reject</a>
                                    </div>
                                <#else>

                                </#if>
                            </li>
                        </#list>

                    </ul>
                <#else>
                    <h5> No Proposals yet.</h5>
                </#if>

            </div>
        </div>
    </div>
    <div class="block block-right">
        <div class="container">
            <h2>${agenda}</h2>

            <h4>Accepted Talks (Public)</h4>
            <#if agendaItems??>
                <ul class="item-list">
                    <#list agendaItems as item>
                        <li>
                            <h5 class="item-list__title">${item.title}</h5>
                            <div class="item-list__author">By ${item.author}
                                @ ${item.talkTime?string('dd.MM.yyyy HH:mm:ss')} </div>
                        </li>
                    </#list>
                </ul>
            <#else>
                <h5> No Items yet.</h5>
            </#if>
        </div>
    </div>
</div>
<script src="js/vendor/modernizr-3.7.1.min.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"
        integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
<script>window.jQuery || document.write('<script src="js/vendor/jquery-3.4.1.min.js"><\/script>')</script>
<script src="js/plugins.js"></script>
<script type="text/javascript">
    // $(document).ready(function () {
    //     setInterval(function () {
    //         window.location = window.location;
    //     }, 3000);
    // });

    function refreshOn() {
        // setInterval(function () {
        //     window.location = window.location;
        // }, 3000);
    }

    function refreshOff() {

    }

    function approveProposal(id) {
        console.log("approving");
        var xhr = new XMLHttpRequest();
        xhr.open("POST", "/c4p/" + id + "/decision", true);
        xhr.setRequestHeader('Content-Type', 'application/json');
        var data = JSON.stringify({
            "approved": true,
            "dayTime": "monday-morning"
        });
        console.log(data);
        xhr.send(data);
        window.location.href = "/";

    }

    function rejectProposal(id) {
        console.log("rejecting");
        var xhr = new XMLHttpRequest();
        xhr.open("POST", "/c4p/" + id + "/decision", true);
        xhr.setRequestHeader('Content-Type', 'application/json');
        var data = JSON.stringify({
            "approved": false
        });
        console.log(data);
        xhr.send(data);
        window.location.href = "/";

    }

    function submitProposal() {
        var xhr = new XMLHttpRequest();
        xhr.open("POST", "/c4p/", true);
        xhr.setRequestHeader('Content-Type', 'application/json');
        var data = JSON.stringify({
            author: document.getElementById("author").value,
            email: document.getElementById("email").value,
            title: document.getElementById("title").value,
            description: document.getElementById("description").value
        });
        console.log(data);
        xhr.send(data);
        window.location.href = "/";
    }
</script>


</body>

</html>