<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Oncology.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="row">
        <div class="PreImages">
        </div>
    </div>

    <div class="row">
        <div style="background-color: #fff; margin-top: 20px; border-color: #31708f; border: 1px solid; text-align: center;">
            <canvas id="canvas" width="800" height="500" style="/* padding: 3px; */margin: 10px; /* margin-top: 10px; */border: 1px solid #d2d2d2;"></canvas>
        </div>


        <div style="margin-top: 20px; margin-bottom: 20px; text-align: center">
            <button type="button" class="btn btn-default disable-clicks" id="clearCanvasSimple" style="font-size: 35px; margin-right: 10px; width: 100px"><i class="fa fa-eraser"></i></button>
            <button type="button" class="btn btn-default disable-clicks" id="SaveImages" style="font-size: 35px; margin-right: 10px; width: 100px" onclick="saveExaminImages()"><i class="fa fa-check-circle-o"></i></button>
            <button type="button" class="btn btn-default" style="font-size: 35px; margin-right: 10px; width: 100px" id="CloseAll" onclick="RedirectToExam();"><i class="fa fa-close"></i></button>
        </div>
    </div>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
    <script src="../Scripts/PatList.js"></script>
    <script src="../Scripts/jquery-ui-touch-punch.js"></script>
    <style>
        canvas:hover {
            cursor: crosshair;
        }

        .activeImage {
            box-shadow: 6px 8px 2px 0px #808080 !important;
        }

        .divtblDisease {
            height: 300px;
            overflow-y: scroll;
        }

        div.divtblDisease::-webkit-scrollbar {
            width: 8px;
        }

        div.divtblDisease::-webkit-scrollbar-track {
            background: rgba(0, 0, 0, 0.1);
        }

        div.divtblDisease::-webkit-scrollbar-thumb {
            background: #b4b6f2;
            border-radius: 3px;
        }
    </style>
    <script>
        var ctx = '';
        var drag = false;
        var imageObj = null;
        var rect = {};
        var clickX = new Array();
        var clickY = new Array();
        var clickDrag = new Array();
        var strCanUrl = '';
        function addClick(x, y, dragging) {
            clickX.push(x);
            clickY.push(y);
            clickDrag.push(dragging);
        }

        function init() {
            imageObj = new Image();
            imageObj.onload = function () { ctx.drawImage(imageObj, 0, 0, canvas.width, canvas.height); };
            imageObj.src = strCanUrl;
            canvas.addEventListener('mousedown', mouseDown, false);
            canvas.addEventListener('mouseup', mouseUp, false);
            canvas.addEventListener('mousemove', mouseMove, false);
        }

        function mouseDown(e) {
            var pos = getMousePos(canvas, e);
            drag = true;
            addClick(pos.x, pos.y);
        }

        function mouseUp() { drag = false; }

        function mouseMove(e) {
            if (drag) {
                var pos = getMousePos(canvas, e);
                ctx.drawImage(imageObj, 0, 0, canvas.width, canvas.height);
                addClick(pos.x, pos.y, true);
                redraw();
            }
        }
        //
        function getMousePos(canvas, evt) {
            var rect = canvas.getBoundingClientRect();
            return {
                x: (evt.clientX - rect.left),
                y: (evt.clientY - rect.top)
            };
        }

        function redraw() {
            ctx.strokeStyle = "#df4b26";
            ctx.lineJoin = "round";
            ctx.lineWidth = 2;

            for (var i = 0; i < clickX.length; i++) {
                ctx.beginPath();
                if (clickDrag[i] && i) {
                    ctx.moveTo(clickX[i - 1], clickY[i - 1]);
                } else {
                    ctx.moveTo(clickX[i] - 1, clickY[i]);
                }
                ctx.lineTo(clickX[i], clickY[i]);
                ctx.closePath();
                ctx.stroke();
            }
        }

        function DisableField() {
            $('#clearCanvasSimple').attr('disabled', true);
            $('#SaveImages').attr('disabled', true);
        }

        function EnableField() {
            $('#clearCanvasSimple').attr('disabled', false);
            $('#SaveImages').attr('disabled', false);
        }

        $(document).ready(function () {
            var urls = "<%=Url.Action("GetDctrClinic","Account")%>";
            SetPatientDtl();
            AddClinics(urls);
            GetAllImages();
            if ($(window).width() >= 996) {
                var menuL = document.getElementById('menuList');
                menuL.style.display = "block";
                var dispLst = document.getElementById('sideList');
                dispLst.style.display = "block";
            }
            var canvas = document.getElementById('canvas');
            ctx = canvas.getContext("2d");
            init();

            $('#clearCanvasSimple').mousedown(function (e) {
                clickX = [];
                clickY = [];
                clickDrag = [];
                ctx.clearRect(0, 0, ctx.canvas.width, ctx.canvas.height)
                ctx.drawImage(imageObj, 0, 0, canvas.width, canvas.height);
            });
        });

            function resizeCanvas(strUrl) {

                imageObjNew = new Image();
                imageObjNew.src = strUrl
                ctx.drawImage(imageObjNew, 0, 0, canvas.width, canvas.height);
            }

    </script>

    <script>
        function ChangeImage(obj) {
            var strUrl = $(obj).find('img').attr('src');
            ctx.clearRect(0, 0, ctx.canvas.width, ctx.canvas.height)
            clickX = [];
            clickY = [];
            clickDrag = [];
            imageObj = new Image();
            imageObj.onload = function () { ctx.drawImage(imageObj, 0, 0, canvas.width, canvas.height); };
            imageObj.src = strUrl;
            canvas.addEventListener('mousedown', mouseDown, false);
            canvas.addEventListener('mouseup', mouseUp, false);
            canvas.addEventListener('mousemove', mouseMove, false);

            var allchild = $('.PreImages').children();

            $.each(allchild, function () {
                var thum = $(this).children();
                if ($(thum).hasClass('activeImage')) {
                    $(thum).removeClass('activeImage');
                }
            })

            var thumelement = $(obj).parent();
            $(thumelement).addClass('activeImage');
            EnableField();
        }

        function GetAllImages() {
            $.ajax({
                type: 'POST',
                url: 'RetriveAllImages',
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (ImageData) {
                    var imageStr = ''
                    $.each(ImageData.ImagePath, function (index, element) {
                        var strfilename = element.replace(/^.*[\\\/]/, '')
                        var strUrl = '../HumanBodyImg/' + ImageData.DocCode + '/' + strfilename;
                        imageStr += '<div class="col-md-3"><div class="thumbnail"><a href="#" onclick="ChangeImage(this)"><img src="' + strUrl + '" alt="Lights" style="width:182px;height:100px"></a></div></div>'
                    })

                    $('.PreImages').append(imageStr);
                }
            });
        }

        function RedirectToExam() {
            window.location.href = '../DoctorDesk/Examination';
        }

    </script>

    <script>
        $(document).ready(function () {
            canvas.addEventListener("touchstart", function (e) {
                var mouseX = (e.changedTouches ? e.changedTouches[0].pageX : e.pageX) - this.offsetLeft,
                    mouseY = (e.changedTouches ? e.changedTouches[0].pageY : e.pageY) - this.offsetTop;
                drag = true;
                addClick(mouseX, mouseY, false);
                redraw();
            }, false);
            canvas.addEventListener("touchmove", function (e) {

                var mouseX = (e.changedTouches ? e.changedTouches[0].pageX : e.pageX) - this.offsetLeft,
                    mouseY = (e.changedTouches ? e.changedTouches[0].pageY : e.pageY) - this.offsetTop;

                if (drag) {
                    addClick(mouseX, mouseY, true);
                    redraw();
                }
                e.preventDefault()
            }, false);
            canvas.addEventListener("touchend", function (e) {
                drag = false;
                redraw();
            }, false);
            canvas.addEventListener("touchcancel", function (e) {
                drag = false;
            }, false);
        })

        function saveExaminImages() {
            var Pic = document.getElementById('canvas').toDataURL("image/png");
            Pic = Pic.replace(/^data:image\/(png|jpg);base64,/, "")
            var strmrno = ($.session.get('PatMRNO')).toString();;
            var strtranNo = ($.session.get('PatTRANNO')).toString();

            datatosend = {
                imageData: Pic,
                MrNo: strmrno,
                TranNo: strtranNo
            }

            $.ajax({
                type: 'POST',
                url: 'Save_Picture',
                data: '{ "imageData" : "' + Pic + '","MrNo" :"' + strmrno + '","TranNo" :"' + strtranNo + '"}',
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (response) {
                    if (("" + response).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                        window.location.href = '../DoctorDesk/Examination';
                    }
                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.loader.close();
                    $.messager.alert("Error", errorThrown);
                }
            });
        }
    </script>
</asp:Content>
