<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Oncology.Master" Inherits="System.Web.Mvc.ViewPage<OncologyEMR.Models.OncologyModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <form id="frmOnchology" method="post">
        <div class="row">
            <div class="col-md-12">
                <div class="nav-tabs-custom marginBottom2">
                    <!-- Tabs within a box -->
                    <ul class="nav nav-tabs pull-right">
                        <%-- <li><a href="#tabCurMedi" data-toggle="tab" class="tabHeaders"><i class="fa fa-medkit"></i>Current Medicines</a></li>--%>
                        <li style="display:none"><a id="lnkShwTRslt" class="tabHeaders" data-toggle="modal" href="#mdAddShwTRslt" style="font-size: 14px; color: green; font-weight: bold">
                            <i class="fa fa-book"></i><u>Show Test Result</u></a></li>
                        <li><a href="#tabNotes" data-toggle="tab" class="tabHeaders"><i class="fa fa-pencil-square-o"></i>Notes</a></li>
                        <li class="active"><a href="#control-sidebar-home-tab" class="tabHeaders" data-toggle="tab"><i class="fa fa-user"></i>Demography</a></li>
                        <li class="pull-left header"><i class="fa fa-user"></i><span id="spPatName"><%:Model.PatName %></span></li>
                    </ul>
                    <div class="tab-content box-body pad2 currentPatTabContent">
                        <div class="tab-pane active" id="control-sidebar-home-tab">
                            <div class="container col-md-12">
                                <div class="row">
                                    <div class="col-md-1 no-padding ">
                                        <img src="<%=ResolveUrl(Model.Imgsrc)%>" class="img-responsive img-rounded"
                                            style="padding-right: 5px; width: 100px; height: 95px" />
                                    </div>
                                    <div class="col-md-11  no-padding ">
                                        <div class="content col-md-3 pad2">
                                            <div class="panel panel-primary no-margin">
                                                <div class="panel-heading pad2">
                                                    <h3 class="panel-title">Patient Details</h3>
                                                </div>
                                                <div class="panel-body pad2 SlimScrollContent">
                                                    <div class="container col-md-12 no-padding">
                                                        <div class="form-inline">
                                                            <div class="form-group no-margin">
                                                                <label>MR.No : </label>
                                                                <span id="spMRNO"><%:Model.MRNO %></span>
                                                                <span id="spCONNO" style="display: none"><%:Model.ConsNo%></span>
                                                                <span id="spTRANMODE" style="display: none"><%:Model.TranMode%></span>
                                                            </div>
                                                            <div class="form-group no-margin">
                                                                <span id="spDoctName" style="display: none;"><%:Model.DoctorName %></span>
                                                                <%--<div id="divDoctName">
                                                                    <label>Doctor Name : </label>
                                                                    <span id="spDoctName"><%:Model.DoctorName %></span>
                                                                    <span id="spDoctCode" style="display: none"><%:Model.DoctorCode%></span>
                                                                </div>
                                                                <div id="divOldDoctName">
                                                                    <label>Doctor Name : </label>
                                                                    `
                                                                </div>--%>
                                                            </div>

                                                            <div class="form-group no-margin">
                                                                <label>DOB : </label>
                                                                <span><%:Model.DOB %></span>
                                                            </div>
                                                            <div class="form-group no-margin">
                                                                <label>Age : </label>
                                                                <span id="spAge"><%:Model.Age %></span>
                                                            </div>
                                                            <div class="form-group no-margin">
                                                                <label>Gender : </label>
                                                                <span id="spGender"><%:Model.Gender %></span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="content col-md-3 pad2">
                                            <div class="panel panel-primary no-margin">
                                                <div class="panel-heading pad2">
                                                    <h3 class="panel-title">Contact Info</h3>
                                                </div>
                                                <div class="panel-body  SlimScrollContent">
                                                    <div class="container col-md-12 no-padding">
                                                        <div class="form-inline">
                                                            <div class="form-group no-margin">
                                                                <label>Address : </label>
                                                                <span><%:Model.PatAdd %></span>
                                                            </div>
                                                            <div class="form-group no-margin">
                                                                <%if (Model.MobileNo.Trim() != "")
                                                                  {%>
                                                                <label>Mobile : </label>
                                                                <span id="spMobile"><%:Model.MobileNo %></span>
                                                                <%}%>
                                                            </div>
                                                            <div class="form-group no-margin">
                                                                <%if (Model.ContactNo.Trim() != "")
                                                                  {%>
                                                                <label>Phone : </label>
                                                                <span><%:Model.ContactNo %></span>
                                                                <%}%>
                                                            </div>
                                                            <div class="form-group no-margin">
                                                                <%if (Model.Email.Trim() != "")
                                                                  {%>
                                                                <label>Email : </label>
                                                                <span><%:Model.Email %></span>
                                                                <%}%>
                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                        <div class="content col-md-3 pad2">

                                            <div class="panel panel-primary no-margin">
                                                <div class="panel-heading pad2 ">
                                                    <h3 class="panel-title">Patient Category Details</h3>
                                                </div>

                                                <div class="panel-body pad2 SlimScrollContent">
                                                    <div class="container no-padding col-md-12">
                                                        <div class="form-inline">
                                                            <div class="form-group no-margin">
                                                                <div id="divPatCatg">
                                                                    <span id="spPatCatg" style="display: none"><%:Model.PatCatGcd %></span>
                                                                    <%if (Convert.ToString("" + Model.CompName).Trim() == "")
                                                                      { %>
                                                                    <span id="spPatcatgnm"><%:Model.PatCatg %></span>
                                                                    <%}
                                                                      else
                                                                      {%>
                                                                    <label>Company : </label>
                                                                    <span id="spCompName"><%:Model.CompName %></span>
                                                                    <%} %>
                                                                </div>
                                                                <div id="divOldPatCatg">
                                                                </div>

                                                            </div>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>




                                        </div>
                                        <div class="content col-md-3 pad2 ">
                                            <div class="panel panel-primary  no-margin">
                                                <div class="panel-heading pad2">
                                                    <h3 class="panel-title">Family Details</h3>
                                                </div>
                                                <div class="panel-body pad2 SlimScrollContent">
                                                    <div class="list-group no-margin">
                                                        <div class="list-group-item pad2">
                                                            <%foreach (OncologyEMR.Models.FamilyHis clfamly in Model.lstFamilyHis)
                                                              {%>
                                                            <%if (clfamly.NAME.Trim() != "")
                                                              { %>
                                                            <div class="list-group-item-heading" style="font-weight: bold;"><%:clfamly.NAME %></div>
                                                            <div class="list-group-item-text">Age:<%:clfamly.AGE %> Relation:<%:clfamly.RELATIONDESC %></div>
                                                            <%} %>
                                                            <%} %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>

                            </div>
                        </div>


                        <div class="tab-pane" id="tabNotes">
                            <div class="container col-md-12">
                                <div class="row">
                                    <div class="col-md-12  no-padding ">
                                        <div class="content col-md-12 pad2  ">
                                            <div class="panel panel-primary no-margin">
                                                <div class="panel-heading pad2 clearfix">
                                                    <h4 class="panel-title pull-left">Notes</h4>
                                                    <a id="lnkNewNotes" class="pull-right" data-toggle="modal" data-target="#mdNewNotes" style="font-size: 12px; color: white">
                                                        <i class="fa fa-pencil-square-o"></i>
                                                        New Notes</a>
                                                </div>

                                                <div class="panel-body SlimScrollContent">
                                                    <%-- <div class="col-md-6">
                                                        <ul class="list-group">
                                                            <ol id="ulOldNotes" type="1">
                                                                <%foreach (string str in Model.lstNotes)
                                                                  { %>
                                                                <li><%:str %></li>

                                                                <%} %>
                                                            </ol>
                                                        </ul>
                                                    </div>--%>

                                                    <div class="col-md-12">
                                                        <ul class="list-group" id="ulNewNotes">
                                                            <%--<ol type="1">
                                                            </ol>--%>
                                                        </ul>
                                                    </div>

                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                        <div class="tab-pane" id="tabCurMedi">
                            <div class="container col-md-12">
                                <div class="row">
                                    <div class="col-md-12  no-padding ">

                                        <div class="panel panel-primary no-margin">
                                            <div class="panel-heading pad2 clearfix">
                                                <h4 class="panel-title pull-left">Current Medicines</h4>
                                            </div>
                                            <div class="panel-body pad2 SlimScrollContent">
                                                <div class="col-md-12">
                                                    <ul class="list-group">
                                                        <ol id="ulMedicine" type="1">
                                                            <%foreach (string str in Model.lstMedicine)
                                                              { %>
                                                            <li><%:str %></li>

                                                            <%} %>
                                                        </ol>
                                                    </ul>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>

                    </div>
                </div>

            </div>
        </div>
        <div class="row">
            <div class="col-md-12">

                <div class="col-sm-2 no-pad-left padRight3">
                    <div class="box box-primary no-margin">
                        <div class="box-header with-border">
                            <span>Last Visit(s)</span>
                            <a id="lnkNew">
                                <span class="fa fa-file pull-right" style="font-weight: bold">&nbsp;New</span>
                            </a>

                        </div>
                        <div class="box-body no-padding">
                            <div id="divLastVisit">
                                <div class="row">
                                    <div class="col-md-6 text-center">
                                        <label>Date</label>
                                    </div>
                                    <div class="col-md-6 text-center">
                                        <label>Tran No</label>
                                    </div>
                                </div>

                                <div class="list-group">
                                    <%foreach (string str in Model.lstLastVisit)
                                      { %>
                                    <div class="list-group-item" style="color: #0d6da4; font-weight: bold;">
                                        <a class="clLastVisit" id="LastVisitid" href="javascript:void(0)">
                                            <span><%:str.Split(',')[0] %></span>
                                            <span class="pull-right"><%:str.Split(',')[1] %></span>
                                            <span style="display: none"><%:str.Split(',')[2] %></span>
                                        </a>
                                    </div>
                                    <%} %>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-10 no-padding">
                    <div class="box no-margin ">
                        <div class="box-body no-padding CurrentTabContent">
                            <div class="nav-tabs-custom no-margin">
                                <ul class="nav nav-tabs">
                                    <li class="active"><a href="#tabPresentComp" class="tabHeaders" data-toggle="tab">Present Comp.</a></li>
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <li><a href="#tabVital" class="tabHeaders" data-toggle="tab">Vitals</a></li>
                                    &nbsp;&nbsp;&nbsp;
                                    <li><a href="#tabMediHist" class="tabHeaders" data-toggle="tab">Diagnosis</a></li>
                                    &nbsp;&nbsp;&nbsp;
                                    <li><a href="#tabDiag" class="tabHeaders" data-toggle="tab">History</a></li>
                                    &nbsp;&nbsp;&nbsp;
                                    <li><a href="#tabPersonalInfo" class="tabHeaders" data-toggle="tab">Personal Info.</a></li>
                                    &nbsp;&nbsp;&nbsp;
                                    <li><a href="#tabFamHist" class="tabHeaders" data-toggle="tab">Family Hist.</a></li>
                                    &nbsp;&nbsp;&nbsp;
                                    <%--<li><a href="#tabObsHist" class="tabHeaders" data-toggle="tab">Obst. Hist.</a></li>--%>
                                    <li><a href="#tabTreatRec" class="tabHeaders" data-toggle="tab">Treat. Rec.</a></li>
                                    &nbsp;&nbsp;&nbsp;
                                    <li><a href="#tabOnExam" class="tabHeaders" data-toggle="tab">On Exam.</a></li>
                                    &nbsp;&nbsp;&nbsp;
                                    <li><a href="#tabInvest" class="tabHeaders" data-toggle="tab">Invest.</a></li>
                                    &nbsp;&nbsp;&nbsp;
                                    <li><a href="#tabMedi" class="tabHeaders" data-toggle="tab">Treatment Advice</a></li>
                                    <%--<li><a href="#tabGenExam" class="tabHeaders" data-toggle="tab">General Exam</a></li>--%>
                                </ul>

                                <div class="CanvasContent tab-content box-body no-margin no-padding">

                                    <div class="tab-pane active" id="tabPresentComp">
                                        <div class="row no-margin">
                                            <div class="col-md-12  no-padding ">
                                                <div class="content col-md-12 pad2">
                                                    <div class="panel panel-primary no-margin">
                                                        <div class="panel-heading pad2 clearfix">
                                                            <h3 class="panel-title pull-left">Present Complaints</h3>
                                                            <a id="lnkAddComp" class="pull-right" data-toggle="modal" data-target="#mdAddComp" style="font-size: 12px; color: white">
                                                                <i class="fa fa-pencil-square-o"></i>
                                                                Add Complaint</a>
                                                        </div>

                                                        <div class="panel-body AllTabContent no-pad-bottom no-pad-top">
                                                            <div class="row">
                                                                <table id="gvComplaints"></table>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-md-3">
                                                                    <span class="form-check-inline">
                                                                        <input class="form-check-input" type="checkbox" id="chkPCOthers" value="Y">
                                                                        Others
                                                                    </span>
                                                                </div>
                                                                <div class="col-md-9 pad2">
                                                                    <textarea id="txtPCOthers" rows="4" class="form-control input-sm" placeholder="Others" maxlength="500"></textarea>
                                                                </div>
                                                            </div>

                                                        </div>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="tab-pane" id="tabVital">

                                        <div class="row no-margin">
                                            <div class="col-md-12  no-padding ">
                                                <div class="content col-md-12 pad2  ">
                                                    <div class="panel panel-primary no-margin">
                                                        <div class="panel-heading pad2">
                                                            <h3 class="panel-title">Vitals</h3>
                                                        </div>

                                                        <div class="panel-body AllTabContent">

                                                            <div class="row pad2">
                                                                <div class="col-md-6">
                                                                    <div class="col-md-6 ">
                                                                        <label>Weight</label>
                                                                    </div>
                                                                    <div class="col-md-6">
                                                                        <div class="input-group">
                                                                            <input type="text" id="txtWeight" maxlength="5" class="form-control input-sm" placeholder="Weight" />
                                                                            <span class="input-group-addon">Kg</span>
                                                                        </div>

                                                                    </div>
                                                                </div>
                                                                <div class="col-md-6 ">

                                                                    <div class="col-md-6">
                                                                        <label>Prev. Weight</label>
                                                                    </div>
                                                                    <div class="col-md-6">
                                                                        <div class="input-group">

                                                                            <input type="text" id="txtPrevWeight" value="<%:Model.PreWeight %>" class="form-control input-sm disabled" disabled="disabled" readonly="readonly" />
                                                                            <span class="input-group-addon">Kg</span>
                                                                        </div>

                                                                    </div>
                                                                </div>

                                                            </div>
                                                            <div class="row">
                                                                <div class="col-md-6">
                                                                    <%--required--%>
                                                                    <div class="col-md-6">
                                                                        <label>Height</label>
                                                                    </div>
                                                                    <div class="col-md-6">
                                                                        <div class="input-group">
                                                                            <input type="text" id="txtHeight" class="form-control input-sm" maxlength="5" placeholder="Height" />
                                                                            <span class="input-group-addon">ft</span>
                                                                        </div>

                                                                    </div>
                                                                </div>
                                                                <div class="col-md-6">

                                                                    <div class="col-md-6">
                                                                        <label id="lblWeightLoss">Weight Loss</label>
                                                                    </div>
                                                                    <div class="col-md-6">
                                                                        <input type="text" id="txtWeightLoss" class="form-control input-sm" disabled="disabled" placeholder="Weight Loss" readonly="readonly" />
                                                                    </div>
                                                                </div>

                                                            </div>
                                                            <div class="row pad2">
                                                                <div class="col-md-6">
                                                                    <div class="col-md-6">
                                                                        <label>Temp.</label>
                                                                    </div>
                                                                    <div class="col-md-6">
                                                                        <input type="text" id="txtTemp" maxlength="5" class="form-control input-sm" placeholder="Temperature" />
                                                                    </div>
                                                                </div>

                                                            </div>
                                                            <div class="row ">
                                                                <div class="col-md-6">
                                                                    <div class="col-md-6">
                                                                        <label>Pulse</label>
                                                                    </div>
                                                                    <div class="col-md-6">
                                                                        <input type="text" id="txtPulse" maxlength="3" class="form-control input-sm" placeholder="Pulse" />
                                                                    </div>
                                                                </div>

                                                            </div>
                                                            <div class="row pad2 ">
                                                                <div class="col-md-6">
                                                                    <div class="col-md-6">
                                                                        <label>Resp.</label>
                                                                    </div>
                                                                    <div class="col-md-6">
                                                                        <input type="text" id="txtResp" maxlength="3" class="form-control input-sm" placeholder="Respiratory " />
                                                                    </div>
                                                                </div>

                                                            </div>
                                                            <div class="row pad2 ">
                                                                <div class="col-md-6">
                                                                    <div class="col-md-6">
                                                                        <label>BP</label>
                                                                    </div>
                                                                    <div class="col-md-6">
                                                                        <input type="text" id="txtBP" maxlength="8" class="form-control input-sm" placeholder="BP" />
                                                                    </div>
                                                                </div>

                                                            </div>
                                                            <div class="row ">
                                                                <div class="col-md-12">
                                                                    <div class="col-md-3 divChifcompalints">
                                                                        <label>Others</label>
                                                                    </div>
                                                                    <div class="col-md-9 divChiefText">
                                                                        <textarea id="txtVitalOthers" rows="4" class="TextBxFormat col-xs-12 form-control" maxlength="500" placeholder="Others"></textarea>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="tab-pane" id="tabPersonalInfo">
                                        <div class="row no-margin">
                                            <div class="col-md-12  no-padding ">
                                                <div class="panel panel-primary no-margin">
                                                    <div class="panel-heading pad2">
                                                        <h3 class="panel-title">Personal Information</h3>
                                                    </div>

                                                    <div class="panel-body AllTabContent no-pad-top">

                                                        <div class="col-md-6 no-pad-left">
                                                            <h4 class="headerBorder text-center">Personal</h4>
                                                            <table id="gvPersonal"></table>

                                                            <div class="col-md-3">
                                                                <span class="form-check-inline">
                                                                    <input class="form-check-input" type="checkbox" id="chkPerOthers" value="Y">
                                                                    Others
                                                                </span>
                                                            </div>
                                                            <div class="col-md-9 pad2">
                                                                <textarea id="txtPerOthers" rows="4" class="form-control input-sm" placeholder="Others" maxlength="500"></textarea>
                                                            </div>

                                                        </div>
                                                        <div class="col-md-6 ">
                                                            <h4 class="headerBorder text-center">Medical</h4>
                                                            <div class="row">
                                                                <table id="gvPersonalMedical"></table>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-md-3">
                                                                    <span class="form-check-inline">
                                                                        <input class="form-check-input" type="checkbox" id="chkPerMedOthers" value="Y">
                                                                        Others
                                                                    </span>
                                                                </div>
                                                                <div class="col-md-9 pad2">
                                                                    <textarea id="txtPerMedOthers" rows="4" class="form-control input-sm" placeholder="Others" maxlength="500"></textarea>
                                                                </div>
                                                            </div>

                                                        </div>
                                                    </div>
                                                </div>


                                            </div>
                                        </div>

                                    </div>
                                    <div class="tab-pane" id="tabFamHist">
                                        <div class="row no-margin">
                                            <div class="col-md-12  no-padding ">

                                                <div class="panel panel-primary no-margin">
                                                    <div class="panel-heading pad2">
                                                        <h3 class="panel-title">Family History</h3>
                                                    </div>

                                                    <div class="panel-body AllTabContent no-padding">
                                                        <table id="gvFamily"></table>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>

                                    </div>

                                    <div class="tab-pane" id="tabTreatRec">

                                        <div class="row no-margin">
                                            <div class="col-md-12  no-padding ">

                                                <div class="panel panel-primary no-margin">
                                                    <div class="panel-heading pad2">
                                                        <h3 class="panel-title">Treatment Received</h3>
                                                    </div>
                                                    <div class="panel-body AllTabContent">
                                                        <div class="col-md-12">
                                                            <table id="gvTreatment"></table>
                                                        </div>
                                                        <div class="col-md-12">
                                                            <div class="list-group no-margin">
                                                                <div class="col-md-4">
                                                                    <div class="list-group-item-heading">
                                                                        <label>Alternative Medicine</label>
                                                                    </div>
                                                                    <div id="divTAlterMed">
                                                                        <span class="form-check-inline">
                                                                            <input class="form-check-input" type="checkbox" id="chkTAlterMYes" value="Y" disabled>
                                                                            Yes
                                                                        </span>
                                                                        <span class="form-check-inline">
                                                                            <input class="form-check-input" type="checkbox" id="chkTAlterMNo" checked="checked" value="N" disabled>
                                                                            No
                                                                        </span>
                                                                    </div>

                                                                </div>
                                                                <div class="col-md-8">
                                                                    <div class="row pad2">
                                                                        <div class="col-md-2">
                                                                            <span>Advice</span>
                                                                        </div>
                                                                        <div class="col-md-10">
                                                                            <textarea class="form-control input-sm" id="txtAlterMedDetails" placeholder="Details" rows="4" maxlength="500" disabled></textarea>
                                                                        </div>
                                                                    </div>

                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>

                                    </div>
                                    <div class="tab-pane" id="tabOnExam">

                                        <div class="row no-margin">
                                            <div class="col-md-12  no-padding ">

                                                <div class="panel panel-primary no-margin">
                                                    <div class="panel-heading pad2">
                                                        <h3 class="panel-title">On Examination</h3>
                                                    </div>

                                                    <div class="panel-body AllTabContent">
                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <textarea id="txtEExam" class="form-control input-sm" maxlength="500" rows="12"></textarea>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <%--<div class="col-md-6 no-padding pad2">
                                                            <div id="divCanvasExam">
                                                                <canvas id="canOnExam" width="10" height="10"></canvas>
                                                            </div>

                                                        </div>--%>
                                                </div>
                                            </div>
                                        </div>

                                    </div>

                                    <div class="tab-pane" id="tabMediHist">

                                        <div class="row no-margin">
                                            <div class="col-md-12  no-padding ">
                                                <div class="panel panel-primary no-margin">
                                                    <div class="panel-heading pad2">
                                                        <h3 class="panel-title">Diagnosis</h3>
                                                    </div>

                                                    <div class="panel-body AllTabContent">
                                                        <div class="row pad2">
                                                            <% Html.RenderPartial("FinalICDUserCntrl", new OncologyEMR.Models.ICDUserCntrlMdl { });%>
                                                        </div>
                                                        <div class="row pad2 ">
                                                            <div class="col-md-12" style="margin-top: 10px;">

                                                                <div class="col-md-1">
                                                                    <span id="icoRemove" title="Remove ICD" class="fa fa-remove fa-lg" style="font-weight: bold; color: black;"></span>
                                                                    <label>ICD</label>
                                                                </div>
                                                                <div class="col-md-2">
                                                                    <div class="input-group">

                                                                        <input type="text" id="txtICDCD" maxlength="3" class="form-control input-sm" placeholder="ICD Code" readonly="readonly" />
                                                                        <%-- <%: Html.TextBoxFor(m => m.ICD, new { id = "txtICDCode", @class = "TextBxFormat",Style = "margin-left: -30px;", PlaceHolder = "ICD Code", onKeydown="BtnSearchEnt()"})%>--%>
                                                                    </div>
                                                                </div>

                                                                <div class="col-md-3">
                                                                    <input type="text" id="txtICDNM" maxlength="3" class="form-control input-sm " style="width: 450px;" placeholder="ICD Name" readonly="readonly" />
                                                                    <%--  <%: Html.TextBoxFor(m => m.ICD, new { id = "txtICD", @class = "TextBxFormat",Style = "width:892px; margin-left: -130px;", PlaceHolder = "ICD Name",onKeydown="BtnSearchEnt()"})%>--%>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row  pad2 ">
                                                            <div class="col-md-12">
                                                                <textarea id="txtDiagnosis" class="form-control input-sm" maxlength="500" rows="12" style="margin-top: 10px; height: 150px;"></textarea>
                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tab-pane" id="tabDiag">

                                        <div class="row no-margin">
                                            <div class="col-md-12  no-padding ">
                                                <div class="panel panel-primary no-margin">
                                                    <div class="panel-heading pad2">
                                                        <h3 class="panel-title">History</h3>
                                                    </div>

                                                    <div class="col-md-6 no-pad-left">
                                                        <h4 class="headerBorder text-center">Past History</h4>
                                                        <textarea id="txtPHist" class="form-control input-sm" maxlength="500" rows="12"></textarea>
                                                    </div>
                                                    <div class="col-md-6 ">
                                                        <h4 class="headerBorder text-center">Surgical History</h4>
                                                        <textarea id="txtSHist" class="form-control input-sm" maxlength="500" rows="12"></textarea>

                                                    </div>


                                                </div>
                                            </div>


                                        </div>

                                    </div>
                                    <div class="tab-pane" id="tabInvest">

                                        <div class="row no-margin">
                                            <div class="col-md-12  no-padding ">

                                                <div class="panel panel-primary no-margin" style="height: 380px">
                                                    <div class="panel-heading pad2">
                                                        <h3 class="panel-title">Investigation</h3>
                                                    </div>

                                                    <div class="panel-body AllTabContent">
                                                        <div class="col-md-12" style="height: 100%">
                                                            <div id="divMultiSelect" style="position: relative; background: radial-gradient(#4c9ac7, #4c9ac7); padding: 2px;">
                                                                <input id="txtsearch" type="text" style="width: 360px" placeholder="Search For Test...." title="Search For Test" />
                                                            </div>

                                                            <table id="GvService">
                                                            </table>
                                                        </div>
                                                        <%--<table id="gvInvest"></table>--%>

                                                        <div class="row">
                                                            <div class="col-md-3">
                                                                <span class="form-check-inline" style="margin-left: 15px;">
                                                                    <input class="form-check-input" type="checkbox" id="chkInvest" value="Y">
                                                                    Others
                                                                </span>
                                                            </div>
                                                            <div class="col-md-9 pad2">
                                                                <textarea id="txtInvest" rows="4" class="form-control input-sm" placeholder="Others" maxlength="500" style="margin-left: -28px;"></textarea>
                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>


                                            </div>
                                        </div>
                                    </div>

                                    <div class="tab-pane" id="tabMedi">

                                        <div class="row no-margin">
                                            <div class="col-md-12  no-padding ">

                                                <div class="panel panel-primary no-margin">

                                                    <div class="panel-heading pad2">
                                                        <h3 class="panel-title">Advice</h3>
                                                    </div>

                                                    <div class="panel-body AllTabContent">
                                                        <div class="row pad2">
                                                            <% Html.RenderPartial("GenericUsrContrl", new OncologyEMR.Models.GenericUsrCntrlMdl { });%>
                                                        </div>
                                                        <div class="col-md-12">
                                                            <table id="gvAdvice"></table>
                                                        </div>

                                                        <div class="col-md-12">
                                                            <div class="list-group no-margin">
                                                                <div class="col-md-4">
                                                                    <div class="list-group-item-heading">
                                                                        <label>Alternative Medicine</label>
                                                                    </div>
                                                                    <div id="divAlterMed">
                                                                        <span class="form-check-inline">
                                                                            <input class="form-check-input" type="checkbox" id="chkAdAlterMYes" value="Y">
                                                                            Yes
                                                                        </span>
                                                                        <span class="form-check-inline">
                                                                            <input class="form-check-input" type="checkbox" id="chkAdAlterMNo" value="N" checked="checked">
                                                                            No
                                                                        </span>
                                                                    </div>

                                                                </div>
                                                                <div class="col-md-8">
                                                                    <div class="row pad2">
                                                                        <div class="col-md-2">
                                                                            <span style="">Advice</span>
                                                                        </div>
                                                                        <div class="col-md-10">
                                                                            <textarea class="form-control input-sm" id="txtAdAlterMedDetails" placeholder="Details" rows="4" maxlength="500" style="width: 100%;"></textarea>
                                                                            <%----UNNATI----%>
                                                                        </div>
                                                                    </div>

                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>


                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="box-footer text-center no-margin pad2">
                            <input type="button" class="btn btn-primary" id="btnSave" value="Save" />
                            <input type="button" class="btn btn-primary" id="btnEdit" value="Edit" />
                            <input type="button" class="btn btn-primary" id="btnPrint" value="Print" />
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="modal fade" id="mdNewNotes" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="myModalLabel">Notes</h4>
                        </div>
                        <div class="modal-body">
                            <textarea id="txtNewNotes" rows="3" class="form-control input-sm" maxlength="200" placeholder="New Note"></textarea>
                        </div>
                        <div class="modal-footer">
                            <button type="button" id="btnCloseNote" class="btn btn-default btn-sm" data-dismiss="modal">Close</button>
                            <button type="button" id="btnSaveNote" class="btn btn-primary btn-sm">Save </button>
                            <br />
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="mdAddComp" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="myCompModalLabel">Complaint</h4>
                        </div>
                        <div class="modal-body">
                            <div class="list-group">
                                <div class="list-group-item">
                                    <textarea id="txtAddComp" rows="1" class="form-control input-sm" placeholder="Complaint"></textarea>
                                </div>
                                <%--<div class="list-group-item">
                                    <label>Type&nbsp;&nbsp;&nbsp;&nbsp;</label>
                                    <input type="radio" id="rbnMain" name="grp" value="main" checked>
                                    Main   
                                    <input type="radio" id="rbnSub" name="grp" value="sub">
                                    Sub&nbsp;&nbsp;&nbsp;&nbsp;
                                    <span id="ComboCont" style="visibility: hidden">
                                        <label>Main Complaint&nbsp;&nbsp;&nbsp;&nbsp;</label>
                                        <%=Html.DropDownListFor(x =>Model.MainCompSel, new SelectList(ViewBag.CompList, "Value", "Text"), "---Select---", new { id="cmbComplaint", style="width:240px"})%><br />
                                    </span>
                                </div>--%>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" id="btnCloseComp" class="btn btn-default btn-sm" data-dismiss="modal">Close</button>
                            <button type="button" id="btnSaveComp" class="btn btn-primary btn-sm">Save </button>
                        </div>
                    </div>
                </div>
            </div>

            <%--   <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>--%>

            <div class="modal fade" id="mdAddShwTRslt" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="display: none">
                <div class="modal-dialog" role="document">
                    <div class="modal-content" style="width: 135%">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <div class="panel no-margin no-padding text-center">
                                <h4 class="box-title"><u>Test Result</u></h4>
                            </div>
                            <%--    <h4 class="Searchinfo">Search Info</h4>
                            <hr />--%>
                            <br />
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-inline SearchDiv">
                                        <label style="font-weight:normal">From Date</label>
                                        <input type="text" id="txtsrchFromDt" name="sFromDt" placeholder="From Date" class="clsMarginRight TextBxFormat Date form-control input-sm" onkeypress="SearchFunc()">
                                        <label style="font-weight:normal">To Date</label>
                                        <input type="text" id="txtsrchToDt" name="sToDt" placeholder="To Date" class="clsMarginRight  Date form-control input-sm" onkeypress="SearchFunc()">&nbsp;&nbsp;&nbsp;
                                           <label style="font-weight:normal">Test Name</label>
                                        <%=Html.DropDownListFor(x =>Model.Testlst, new SelectList((IEnumerable<OncologyEMR.Oncology.BL_GeneralFunctionsSelectLstItem>)Model.TestList  , "Value", "Text"), "---Select---", new {@class = "clsMarginRight TextBxFormat form-control input-sm", id = "ddlTestlst",Style="width:180px"})%>
                                        <a id="btnSearch" href="#">
                                            <span class="fa fa-search fa-lg"></span>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-body">
                            <table id="gvShwTRslt"></table>
                        </div>
                        <div class="modal-footer" style="display: none" id="MDFTR">
                            <button type="button" id="btnClose" data-dismiss="modal"></button>

                        </div>


                    </div>

                </div>
            </div>
        </div>


        <div id="divTranInfo" style="font-weight: bold;">
            <%----unnati-- changed font weight--%>
            <%--style="display: none"--%>
            <span id="spTranNo"><%:Model.TRANNO%></span>
            <span id="spTranDt"><%:Model.TRANDT%></span>
            <span id="spTranTM"><%:Model.TRANTM%></span>
        </div>

        <div class="modal  fade" id="mdPrint" tabindex="-1" role="dialog" aria-labelledby="PrintLabel">
            <div class="modal-dialog md-dialog" role="document">
                <div class="modal-content md-content">
                    <div class="modal-header md-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title md-title" id="PrintLabel"></h4>
                    </div>
                    <div class="modal-body md-body">
                        <div id="iframe" style="height: 100%">
                        </div>


                    </div>
                </div>
            </div>
        </div>
    </form>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
       <%: System.Web.Optimization.Scripts.Render("~/Scripts/jqGrid") %>
    <script type="text/javascript">
        var Trsann = '<%:Model.TRANNO%>';
        var TranMode = '<%=Model.TranMode%>';
        var AddGridItems;
        var link;
        var saverow;
        var savecol;
        var gRedirecturl = "";
        var complFlag = false;
        //var complArrdata = "";
        var complArrdata = new Array();//storing only rowid
        var complArrdata2 = new Array();//storing row data
        var PGLoadYN = "Y";
        var searchGDYN = "N";
        var YearData = {
            "1": "1", "2": "2", "3": "3", "4": "4", "5": "5", "6": "6"
                   , "7": "7", "8": "8", "9": "9", "10": "10",
            "11": "11", "12": "12", "13": "13", "14": "14", "15": "15", "16": "16"
                   , "17": "17", "18": "18", "19": "19", "20": "20",
            "21": "21", "22": "22", "23": "23", "24": "24", "25": "25", "26": "26"
                   , "27": "27", "28": "28", "29": "29", "30": "30",
            "31": "31", "32": "32", "33": "33", "34": "34", "35": "35", "36": "36"
                   , "37": "37", "38": "38", "39": "39", "40": "40",
            "41": "41", "42": "42", "43": "43", "44": "44", "45": "45", "46": "46"
                   , "47": "47", "48": "48", "49": "49", "50": "50",
            "51": "51", "52": "52", "53": "53", "54": "54", "55": "55", "56": "56"
                   , "57": "57", "58": "58", "59": "59", "60": "60",
            "61": "61", "62": "62", "63": "63", "64": "64", "65": "65", "66": "66"
                   , "67": "67", "68": "68", "69": "69", "70": "70",
            "71": "71", "72": "72", "73": "73", "74": "74", "75": "75", "76": "76"
                   , "77": "77", "78": "78", "79": "79", "80": "80",
            "81": "81", "82": "82", "83": "83", "84": "84", "85": "85", "86": "86"
                   , "87": "87", "88": "88", "89": "89", "90": "90",
            "91": "91", "92": "92", "93": "93", "94": "94", "95": "95", "96": "96"
                   , "97": "97", "98": "98", "99": "99", "100": "100"
        };
        var gDurType = { 'D': 'Day', 'W': 'Week', 'M': 'Month', 'Y': 'Year' };
        var gDStatus = { 'L': 'Live', 'D': 'Death' };

        var gRelation = {
            '01': 'Father', '02': 'Mother', '03': 'Wife',
            '04': 'Brother', '05': 'Sister', '06': 'Grand Father',
            '07': 'Grand Mother'
        };
        var gPreCompdata = new Array(); var gPreSubCompdata = new Array();
        //var gPreCompdata = [{ DESCCD: '01', CHECK: 'False', DESC: 'PV bleeding' },
        //      { DESCCD: '02', CHECK: 'False', DESC: 'White discharge PV' },
        //   { DESCCD: '03', CHECK: 'False', DESC: 'Post coital bleeding ' },
        //   { DESCCD: '04', CHECK: 'False', DESC: 'Low Backache' },
        //   { DESCCD: '05', CHECK: 'False', DESC: 'Generalized weakness' },
        //   { DESCCD: '06', CHECK: 'False', DESC: 'Increased frequency of micturition' },
        //   { DESCCD: '07', CHECK: 'False', DESC: 'Pain in lower abdomen' },
        //   { DESCCD: '08', CHECK: 'False', DESC: 'Breathlessness' },
        //  { DESCCD: '09', CHECK: 'False', DESC: 'Cough' }];
        //var gPreSubCompdata = [{ DESCCD: '01', GRPCD: '01', CHECK: 'False', DESC: 'PV bleeding' },
        //      { DESCCD: '02', GRPCD: '02', CHECK: 'False', DESC: 'White [discharge] PV' },
        //   { DESCCD: '03', GRPCD: '03', CHECK: 'False', DESC: 'Post coital bleeding ' },
        //   { DESCCD: '04', GRPCD: '04', CHECK: 'False', DESC: 'Low Backache' },
        //   { DESCCD: '05', GRPCD: '05', CHECK: 'False', DESC: 'Generalized weakness' },
        //   { DESCCD: '06', GRPCD: '06', CHECK: 'False', DESC: 'Increased frequency of micturition' },
        //   { DESCCD: '07', GRPCD: '07', CHECK: 'False', DESC: 'Pain in lower abdomen' },
        //   { DESCCD: '08', GRPCD: '08', CHECK: 'False', DESC: 'Breathlessness' },
        //  { DESCCD: '09', GRPCD: '08', CHECK: 'False', DESC: 'Cough' }];
        var gPersonaldata = [{ CHECK: 'False', ADDICTCD: '01', DESC: 'Alcohol', locked: true },
              { CHECK: 'False', ADDICTCD: '02', DESC: 'Amphetamines', locked: true },
           { CHECK: 'False', ADDICTCD: '03', DESC: 'Cocaine', locked: true },
          { CHECK: 'False', ADDICTCD: '04', DESC: 'Drugs', locked: true },
        { CHECK: 'False', ADDICTCD: '05', DESC: 'Opioids', locked: true },
        { CHECK: 'False', ADDICTCD: '06', DESC: 'Smoking', locked: true },
        { CHECK: 'False', ADDICTCD: '07', DESC: 'Tobacco', locked: true }];

        var gPerMeddata = [{ CHECK: 'False', MEDCD: '01', DESC: 'Hypertension ', locked: true },
           { CHECK: 'False', MEDCD: '02', DESC: 'Diabetes', locked: true },
        { CHECK: 'False', MEDCD: '03', DESC: 'Tuberculosis', locked: true },
        { CHECK: 'False', MEDCD: '04', DESC: 'Cancer', locked: true },
        { CHECK: 'False', MEDCD: '05', DESC: 'Asthma', locked: true },
         { CHECK: 'False', MEDCD: '06', DESC: 'Obesity', locked: true },
         { CHECK: 'False', MEDCD: '07', DESC: 'Alzheimer disease', locked: true },
        { CHECK: 'False', MEDCD: '08', DESC: 'Osteoporosis', locked: true },
        { CHECK: 'False', MEDCD: '09', DESC: 'Cardiovascular Disease', locked: true }];

        var gTreatmentdata = [];
        var gAdvicedata = [];
          <% var Samp = new System.Web.Script.Serialization.JavaScriptSerializer(); %>
        var gFamilyHis = JSON.parse(JSON.stringify(<%:Html.Raw(Samp.Serialize(Model.lstFamilyHis))%>));
        var DoctorCode = '<%:Session["gDoctCode"].ToString() %>';//Somnath
        var CreatedBy = '<%:Session["gOncoUserId"].ToString() %>';
        var gcanwidth = 0;
        var gcanheight = 0;
        var drawing = false;
        var rowadded = false;
        var rowaddedHIS = false;
        $(function () {
            $('#download').hide();
        });
        function createSearchControl(name) {
            $.ajax({
                type: 'post',
                //  data: datatosend, // $("#OpBill").serialize(),
                url: 'GetServiceSearchInfo',
                cache: false,
                //   contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function (result) {
                    var $newDiv = $('<div>');
                    $newDiv.attr("id", name);
                    $newDiv.attr("name", name);
                    $newDiv.addClass("searchdivclass");
                    $newDiv.css('width', '360px');
                    $newDiv.css('height', '100px');
                    $newDiv.css('overflow', 'auto');
                    $newDiv.css('display', 'none');
                    $newDiv.css('border-color', '#f47b02;');
                    $newDiv.css(' border-style', 'solid');
                    $newDiv.css('background', 'azure');
                    $newDiv.css('left', '0px');
                    $newDiv.css('top', '30px');
                    var $newul = $('<ul>');
                    $newul.attr("id", "Servicedata");
                    $newul.addClass("searchlistclass");
                    var options = "";
                    //Iterated over the IEnumerable list.
                    var i = 0;
                    $.each(result, function (i, item) {
                        var title = item.Text;
                        var idstring = name + i;
                        //Each option represents a value in dropdown. For each element in the list, option element is created and appended to the stringBuilder object.
                        options += "<li><label><input type=checkbox id='" + idstring + "' title='" + title + "' value='" + item.Value + "'>" + title + "</label><li>";
                    });
                    $newul.append(options);
                    $newDiv.append($newul);
                    $('#divMultiSelect').append($newDiv);
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.messager.alert("Information", "An error occurred while processing your request.");

                }
            });
        }
        $(document).ready(function (e) {

            //new btn hide /show
            if (TranMode == 1) {
                $('#lnkNew').css('display', 'block');
                $('#txtAdAlterMedDetails').val('Follow up on ');
            }
            else {
                $('#lnkNew').css('display', 'none');
            }
            //end


            //test result 
           // $('#ddlTestlst').select2();
            TestResultGridDetails();
            $("#btnSearch").click(function () {
                RSearch();
            });
            $('#lnkShwTRslt').click(function () {
                $("#gvShwTRslt").clearGridData();
                $('#txtsrchFromDt').prop('disabled', false);
                $('#txtsrchToDt').prop('disabled', false);
            });
            //end


            //save complaints
            $("#btnSaveComp").click(function (e) {
                var GroupCode = "";
                var Complaint = "";
                if ($("#rbnSub")[0].checked == true) {
                    GroupCode = $("#cmbComplaint")[0].value;
                }
                Complaint = $("#txtAddComp")[0].value;
                if ($("#txtAddComp")[0].value.length > 0) {
                    $.ajax({
                        type: "POST",
                        url: "../DoctorDesk/SaveMainCompAddItem",
                        data: { DESC: Complaint, GRPCD: GroupCode },
                        dataType: "json",
                        async: false,
                        success: function (response) {
                            if (("" + response).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                                $("#txtAddComp")[0].value = ""; $("#cmbComplaint")[0].value = ""; $("#btnCloseComp").click();
                                $.messager.alert("Information", response);
                                if ($("#rbnSub")[0].checked == true) {
                                    GetComplaintSubLst();
                                }
                                else
                                    CreateCompalintGrid();
                                BindComplaintGridOnLoad();
                            }
                            else {
                                $("#btnCloseComp").click();
                                $.messager.alert("Information", "This complaint is allready Present.");
                            }

                        }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                            $.messager.alert("Information", "An error occurred while processing your request.");

                        }
                    });
                }
            })
            $("#cmbComplaint").select2();
            $('#btnPrint').hide();
            $('#btnEdit').hide();

            $("#txtsearch").click(function (e) {
                this.select();
                $("#dblServiceHelp").show();
                e.stopPropagation();
            });

            $(document).click(function () {
                $("#dblServiceHelp").hide();
                $('#txtsearch').val("");
            });
            createSearchControl("dblServiceHelp");
            //servicehelp();
            $('#txtsearch').change(function (e) {
                var searchtext = $(this).val();
                var allinput = document.getElementById('Servicedata').getElementsByTagName('label');
                var regX = new RegExp("\\s(" + searchtext + "[^\\s]*)|^(" + searchtext + "[^\\s]*)", "gi");
                for (i = 0; i < allinput.length; i++) {
                    if (allinput[i].textContent.match(regX)) {
                        allinput[i].style.display = 'block';
                    }
                    else {
                        allinput[i].style.display = 'none';
                    }
                }
            });

            $('#icoRemove').click(function (e) {
                $('#txtICDCD').val('');
                $('#txtICDNM').val('');
            });

            $("#dblServiceHelp li input").click(function (e) {
                if (e.currentTarget.checked === true) {
                    //var strSpanRemo = '<span class="ui-icon ui-icon-cancel">Remove</span>';

                    var servCode = e.currentTarget.value;
                    var newRow = {
                        TESTCODE: e.currentTarget.value,
                        TESTNAME: e.currentTarget.title
                    }
                    $('#GvService').addRowData(servCode, newRow, 'last');
                } else {
                    var servCode = e.currentTarget.value;
                    jQuery('#GvService').delRowData(servCode);
                }
                $("#dblServiceHelp").show();
                e.stopPropagation();
            });



            $('.SlimScrollContent').slimScroll({
                height: '67px',
                size: '4px',
                axis: 'both',
                width: '100%',
                opacity: 0.4,
                distance: 0,
                wheelStep: '1',
                disableFadeOut: true
            }).css("white-space", "normal").hover(function (e) {
                $(this).next('.slimScrollBarX').css('opacity', 0.4);
            });

            $('#dlStage').width(100).select2();
            $('#dlStageUnit').width(100).select2();
            $('#divLastVisit').slimScroll({
                height: '',
                size: '3px',
                axis: 'both',
                width: '100%',
                opacity: 0.4,
                distance: 0,

                disableFadeOut: true,
                alwaysVisible: true
            });
            $('#txtWeight ,#txtHeight,#txtTemp').inputmask("Regex", { regex: "^[0-9]{1,3}(\\.\\d{0,2})?$", placeholder: '0' });
            $('#txtWeight').change(function (e) {
                var prevWeight = $('#txtPrevWeight').val();
                $('#lblWeightLoss').text('Weight Loss');
                if (Number(prevWeight) > 0) {
                    var WeightLoss = 0;
                    if (prevWeight >= Number($('#txtWeight').val())) {
                        WeightLoss = Number(prevWeight) - Number($('#txtWeight').val());
                        $('#lblWeightLoss').text('Weight Loss');
                    }
                    else if (prevWeight < Number($('#txtWeight').val())) {
                        WeightLoss = Number($('#txtWeight').val()) - Number(prevWeight);
                        $('#lblWeightLoss').text('Weight Gain');
                    }
                    $('#txtWeightLoss').val(WeightLoss.toFixed(2));
                }

                else {
                    $('#txtWeightLoss').val("0");
                }

            });

            $('.fa-calendar').click(function (e) {
                if (!$('#btnSave').is(":visible")) {
                    return false;
                }
                $(this).parent().parent().children().focus();
            });
            // end slim scroll Function
            $(".Date").datepicker({
                showButtonPanel: true,
                changeMonth: true,
                yearRange: "c-150:c+99",
                changeYear: true,
                dateFormat: "dd/mm/yy",
                maxDate: new Date()
            }).inputmask('dd/mm/yyyy')


            //save transaction btnclick
            $('#btnSave').click(function (e) {
                var lenghth = $(".edit-cell > *").length;
                for (var i = 0; i < lenghth; i++) {
                    e = jQuery.Event("keydown");
                    e.keyCode = $.ui.keyCode.ENTER;
                    edit = $(".edit-cell > *");
                    edit.trigger(e);
                }

                SaveRecord();

            });

            //this function for invest checkbox event

            //this for Biobsy Checkbox event
            $('#divBiopsyCheck input:checkbox').click(function (e) {

                if ($('#divBiopsyCheck input[type=checkbox]:checked').length > 1) {
                    $('#divBiopsyCheck input:checkbox').prop('checked', false);
                    $(this).prop('checked', true);
                }
                $('#txtBiOthers').hide();
                $('#txtBiOthers').val('');
                if (e.target.id == "chkBiOthers") {
                    if (e.target.checked) {
                        $('#txtBiOthers').show();
                    }
                }

            });
            $('#chkBiopsy').click(function (e) {

                if (e.target.checked) {
                    $('#divBiopsy').show();
                }
                else {
                    $('#divBiopsyCheck input:checkbox').prop('checked', false);
                    $('#divBiopsy input:text').val('');
                    $('#divBiopsy').hide();
                }
            });
            //end biobsy Checkbox

            //start Ct And Abodoment Checkbox Event
            $('#chkAbdomen').click(function (e) {
                if (e.target.checked) {
                    $('#divAbdomen').show();
                }
                else {
                    $('#divAbdomen input:checkbox').prop('checked', false);
                    $('#divAbdomen input:text').val('');
                    $('#txtHNPSize').hide();
                    $('#txtHNPSite').hide();
                    $('#divAbdomen').hide();
                    $('#divNoteSizeSite').hide();
                    $('#divNotePresent').hide();

                    $('#divHydronePresent').hide();
                    $('#divHydroneLeftPresent').hide();
                    $('#divHydroneRightPresent').hide();
                }
            });

            $('#divfbladder input:checkbox').click(function (e) {
                if ($('#divfbladder input[type=checkbox]:checked').length > 1) {
                    $('#divfbladder input:checkbox').prop('checked', false);
                    $(this).prop('checked', true);
                }
            });

            $('#divfrectum input:checkbox').click(function (e) {
                if ($('#divfrectum input[type=checkbox]:checked').length > 1) {
                    $('#divfrectum input:checkbox').prop('checked', false);
                    $(this).prop('checked', true);
                }
            });
            $('#divBInvolve input:checkbox').click(function (e) {
                if ($('#divBInvolve input[type=checkbox]:checked').length > 1) {
                    $('#divBInvolve input:checkbox').prop('checked', false);
                    $(this).prop('checked', true);
                }
            });
            $('#divRInvolve input:checkbox').click(function (e) {
                if ($('#divRInvolve input[type=checkbox]:checked').length > 1) {
                    $('#divRInvolve input:checkbox').prop('checked', false);
                    $(this).prop('checked', true);
                }
            });
            $('#divNotePresent input:checkbox').click(function (e) {
                if ($('#divNotePresent input[type=checkbox]:checked').length > 1) {
                    $('#divNotePresent input:checkbox').prop('checked', false);
                    $(this).prop('checked', true);
                }
                $('#divNotePresent input:text').hide();
                $('#divNotePresent input:text').val('');
                if (e.target.id == "chkCNotePresentSize") {
                    if (e.target.checked) {
                        $('#divNoteSizeSite').show();
                        $('#txtHNPSize').show();
                    }
                }
                else {
                    if (e.target.checked) {
                        $('#divNoteSizeSite').show();
                        $('#txtHNPSite').show();
                    }
                }
            });
            $('#divInvestNote input:checkbox').click(function (e) {
                if ($('#divInvestNote input[type=checkbox]:checked').length > 1) {
                    $('#divInvestNote input:checkbox').prop('checked', false);
                    $(this).prop('checked', true);
                }
                $('#divNotePresent').hide();
                $('#divNotePresent input:text').val('');
                if (e.target.id == "chkCNotePresent") {
                    if (e.target.checked) {
                        $('#divNotePresent').show();
                    }
                    else {
                        $('#divNotePresent input:checkbox').prop('checked', false);
                    }
                }
                else {
                    $('#divNotePresent input:checkbox').prop('checked', false);
                }
            });

            $('#divHydronePresAbs input:checkbox').click(function (e) {
                if ($('#divHydronePresAbs input[type=checkbox]:checked').length > 1) {
                    $('#divHydronePresAbs input:checkbox').prop('checked', false);
                    $(this).prop('checked', true);
                }
                $('#divHydronePresent').hide();
                $('#divHydroneRightPresent').hide();
                $('#divHydroneLeftPresent').hide();


                if (e.target.id == "chkHPresent") {
                    if (e.target.checked) {
                        $('#divHydronePresent').show();
                    }
                    else {
                        $('#divHydronePresent input:checkbox').prop('checked', false);
                        $('#divHydroneRightPresent input:checkbox').prop('checked', false);
                        $('#divHydroneLeftPresent input:checkbox').prop('checked', false);
                    }
                }
                else {
                    $('#divHydronePresent input:checkbox').prop('checked', false);
                    $('#divHydroneRightPresent input:checkbox').prop('checked', false);
                    $('#divHydroneLeftPresent input:checkbox').prop('checked', false);
                }
            });

            $('#divHydronePresent input:checkbox').click(function (e) {
                if ($('#divHydronePresent input[type=checkbox]:checked').length > 1) {
                    $('#divHydronePresent input:checkbox').prop('checked', false);
                    $(this).prop('checked', true);
                }
                $('#divHydroneLeftPresent').hide();
                $('#divHydroneRightPresent').hide();
                $('#divHydroneLeftPresent input:checkbox').prop('checked', false);
                $('#divHydroneRightPresent input:checkbox').prop('checked', false);
                if (e.target.id == "chkHLeft") {
                    if (e.target.checked) {
                        $('#divHydroneLeftPresent').show();
                    }

                }
                else if (e.target.id == "chHRight") {
                    if (e.target.checked) {
                        $('#divHydroneRightPresent').show();
                    }
                }

            });
            $('#divHydroneRightPresent input:checkbox').click(function (e) {
                if ($('#divHydroneRightPresent input[type=checkbox]:checked').length > 1) {
                    $('#divHydroneRightPresent input:checkbox').prop('checked', false);
                    $(this).prop('checked', true);
                }
            });
            $('#divHydroneLeftPresent input:checkbox').click(function (e) {
                if ($('#divHydroneLeftPresent input[type=checkbox]:checked').length > 1) {
                    $('#divHydroneLeftPresent input:checkbox').prop('checked', false);
                    $(this).prop('checked', true);
                }
            });


            //MRI
            $('#chkMRI').click(function (e) {
                if (e.target.checked) {
                    $('#divMRI').show();
                }
                else {
                    $('#divMRI input:checkbox').prop('checked', false);
                    $('#divMRI input:text').val('');
                    $('#txtMHNPSize').hide();
                    $('#txtMHNPSite').hide();
                    $('#divMRI').hide();
                    $('#divNoteSizeSite').hide();
                    $('#divMNotePresent').hide();
                    $('#divMHydronePresent').hide();
                    $('#divMHydroneLeftPresent').hide();
                    $('#divMHydroneRightPresent').hide();
                }
            });

            $('#divMfbladder input:checkbox').click(function (e) {
                if ($('#divMfbladder input[type=checkbox]:checked').length > 1) {
                    $('#divMfbladder input:checkbox').prop('checked', false);
                    $(this).prop('checked', true);
                }
            });

            $('#divMfrectum input:checkbox').click(function (e) {
                if ($('#divMfrectum input[type=checkbox]:checked').length > 1) {
                    $('#divMfrectum input:checkbox').prop('checked', false);
                    $(this).prop('checked', true);
                }
            });
            $('#divMBInvolve input:checkbox').click(function (e) {
                if ($('#divMBInvolve input[type=checkbox]:checked').length > 1) {
                    $('#divMBInvolve input:checkbox').prop('checked', false);
                    $(this).prop('checked', true);
                }
            });
            $('#divMRInvolve input:checkbox').click(function (e) {
                if ($('#divMRInvolve input[type=checkbox]:checked').length > 1) {
                    $('#divMRInvolve input:checkbox').prop('checked', false);
                    $(this).prop('checked', true);
                }
            });
            $('#divMNotePresent input:checkbox').click(function (e) {
                if ($('#divMNotePresent input[type=checkbox]:checked').length > 1) {
                    $('#divMNotePresent input:checkbox').prop('checked', false);
                    $(this).prop('checked', true);
                }
                $('#divMNotePresent input:text').hide();
                $('#divMNotePresent input:text').val('');
                if (e.target.id == "chkMNotePresentSize") {
                    if (e.target.checked) {
                        $('#divNoteSizeSite').show();
                        $('#txtMHNPSize').show();
                    }
                }
                else {
                    if (e.target.checked) {
                        $('#divNoteSizeSite').show();
                        $('#txtMHNPSite').show();
                    }
                }
            });
            $('#divMInvestNote input:checkbox').click(function (e) {
                if ($('#divMInvestNote input[type=checkbox]:checked').length > 1) {
                    $('#divMInvestNote input:checkbox').prop('checked', false);
                    $(this).prop('checked', true);
                }
                $('#divMNotePresent').hide();
                $('#divMNotePresent input:text').val('');
                if (e.target.id == "chkMNotePresent") {
                    if (e.target.checked) {
                        $('#divMNotePresent').show();
                    }
                    else {
                        $('#divMNotePresent input:checkbox').prop('checked', false);
                    }
                }
                else {
                    $('#divMNotePresent input:checkbox').prop('checked', false);
                }
            });

            $('#divMHydronePresAbs input:checkbox').click(function (e) {
                if ($('#divMHydronePresAbs input[type=checkbox]:checked').length > 1) {
                    $('#divMHydronePresAbs input:checkbox').prop('checked', false);
                    $(this).prop('checked', true);
                }
                $('#divMHydronePresent').hide();
                $('#divMHydroneRightPresent').hide();
                $('#divMHydroneLeftPresent').hide();


                if (e.target.id == "chkMHPresent") {
                    if (e.target.checked) {
                        $('#divMHydronePresent').show();
                    }
                    else {
                        $('#divMHydronePresent input:checkbox').prop('checked', false);
                        $('#divMHydroneRightPresent input:checkbox').prop('checked', false);
                        $('#divMHydroneLeftPresent input:checkbox').prop('checked', false);
                    }
                }
                else {
                    $('#divMHydronePresent input:checkbox').prop('checked', false);
                    $('#divMHydroneRightPresent input:checkbox').prop('checked', false);
                    $('#divMHydroneLeftPresent input:checkbox').prop('checked', false);
                }
            });

            $('#divMHydronePresent input:checkbox').click(function (e) {
                if ($('#divMHydronePresent input[type=checkbox]:checked').length > 1) {
                    $('#divMHydronePresent input:checkbox').prop('checked', false);
                    $(this).prop('checked', true);
                }
                $('#divMHydroneLeftPresent').hide();
                $('#divMHydroneRightPresent').hide();
                $('#divMHydroneLeftPresent input:checkbox').prop('checked', false);
                $('#divMHydroneRightPresent input:checkbox').prop('checked', false);
                if (e.target.id == "chkMHLeft") {
                    if (e.target.checked) {
                        $('#divMHydroneLeftPresent').show();
                    }

                }
                else if (e.target.id == "chMHRight") {
                    if (e.target.checked) {
                        $('#divMHydroneRightPresent').show();
                    }
                }

            });
            $('#divMHydroneRightPresent input:checkbox').click(function (e) {
                if ($('#divMHydroneRightPresent input[type=checkbox]:checked').length > 1) {
                    $('#divMHydroneRightPresent input:checkbox').prop('checked', false);
                    $(this).prop('checked', true);
                }
            });
            $('#divMHydroneLeftPresent input:checkbox').click(function (e) {
                if ($('#divMHydroneLeftPresent input[type=checkbox]:checked').length > 1) {
                    $('#divMHydroneLeftPresent input:checkbox').prop('checked', false);
                    $(this).prop('checked', true);
                }
            });
            //end Mri

            $('#chkIHIV').click(function (e) {

                if (e.target.checked) {
                    $('#divHIV').show();
                }
                else {
                    $('#divHIV input:checkbox').prop('checked', false);
                    $('#divHIV input:text').val('');
                    $('#divHIV').hide();
                }
            });

            $('#divHIVReactive input:checkbox').click(function (e) {
                if ($('#divHIVReactive input[type=checkbox]:checked').length > 1) {
                    $('#divHIVReactive input:checkbox').prop('checked', false);
                    $(this).prop('checked', true);
                }
            });
            $('#chkIHbsAg').click(function (e) {

                if (e.target.checked) {
                    $('#divHBsAg').show();
                }
                else {
                    $('#divHBsAg input:checkbox').prop('checked', false);
                    $('#divHBsAg input:text').val('');
                    $('#divHBsAg').hide();
                }
            });

            $('#divHbsReactive input:checkbox').click(function (e) {
                if ($('#divHbsReactive input[type=checkbox]:checked').length > 1) {
                    $('#divHbsReactive input:checkbox').prop('checked', false);
                    $(this).prop('checked', true);
                }
            });

            $('#chkICreatine').click(function (e) {

                if (e.target.checked) {
                    $('#divCreatinine').show();
                }
                else {
                    $('#divCreatinine input:text').val('');
                    $('#divCreatinine').hide();
                }
            });
            $('#chkICBC').click(function (e) {

                if (e.target.checked) {
                    $('#divCBC').show();
                }
                else {
                    $('#divCBC input:text').val('');
                    $('#divCBC').hide();
                }
            });
            $('#chkIXray').click(function (e) {

                if (e.target.checked) {
                    $('#divXray').show();

                }
                else {
                    $('#divXray').hide();
                    $('#divXrayOther input:text').val('');
                    $('#divXray input:checkbox').prop('checked', false);
                    $('#divXrayOther').hide();
                }
            });
            $('#divXrayNormal input:checkbox').click(function (e) {
                if ($('#divXrayNormal input[type=checkbox]:checked').length > 1) {
                    $('#divXrayNormal input:checkbox').prop('checked', false);
                    $(this).prop('checked', true);
                }
                $('#divXrayOther').hide();
                $('#txtXrayother').val('');
                if (e.target.id === "chkxrayOthers") {
                    if (e.target.checked === true) {
                        $('#divXrayOther').show();
                    }
                    else {

                    }
                }
            });
            $('#chkIColonoscopy').click(function (e) {

                if (e.target.checked) {
                    $('#divColonoscopy').show();
                }
                else {
                    $('#divColonoscopy input:checkbox').prop('checked', false);
                    $('#divColonoscopy').hide();
                }
            });
            $('#divClonoNormal input:checkbox').click(function (e) {
                if ($('#divClonoNormal input[type=checkbox]:checked').length > 1) {
                    $('#divClonoNormal input:checkbox').prop('checked', false);
                    $(this).prop('checked', true);
                }
            });

            $('#chkCystoscopy').click(function (e) {

                if (e.target.checked) {
                    $('#divCystoscopy').show();
                }
                else {
                    $('#divCystoscopy input:checkbox').prop('checked', false);
                    $('#divCystoscopy').hide();
                }
            });
            $('#divCystosNormal input:checkbox').click(function (e) {
                if ($('#divCystosNormal input[type=checkbox]:checked').length > 1) {
                    $('#divCystosNormal input:checkbox').prop('checked', false);
                    $(this).prop('checked', true);
                }
            });

            $('#mdNewNotes').on('show.bs.modal', function (e) {
                $('#txtNewNotes').css('border-color', '');
                $('#txtNewNotes').val('');
            })
            $('#txtNewNotes').blur(function (e) {
                $('#txtNewNotes').css('border-color', '');

            });


            //save notes 
            $('#btnSaveNote').click(function (e) {

                if ($('#txtNewNotes').val().trim() !== "") {
                    $('#ulNewNotes').append('<li>' + " * " + $('#txtNewNotes').val() + '</li>');
                    $('#mdNewNotes').modal('hide');

                    //new code
                    var Notes = "";
                    var MRNO = "";
                    var TransactNo = "";
                    Notes = $("#txtNewNotes")[0].value;
                    Notes = Notes.trim();
                    MRNO = $('#spMRNO').text().trim();
                    TransactNo = $('#spTranNo').text().trim();
                    if ($("#txtNewNotes")[0].value.length > 0) {
                        $.ajax({
                            type: "POST",
                            url: "../DoctorDesk/SaveMainNotes",
                            data: { Notes: Notes, MRNO: MRNO, TransactNo: TransactNo },
                            dataType: "json",
                            async: false,
                            success: function (response) {
                                if (("" + response).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                                    $("#txtNewNotes")[0].value = ""; $("#btnCloseNote").click();
                                    $.messager.alert("Information", response);
                                }
                                //else {
                                //    $("#btnCloseNote").click();
                                //    $.messager.alert("Information", "This notes is allready Present.");
                                //}

                            }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                                $.messager.alert("Information", "An error occurred while processing your request.");

                            }
                        });
                    }

                }
                    //end
                else {
                    $('#txtNewNotes').css('border-color', 'red');

                }

            });
            //end

            $('#chkPCOthers').click(function (e) {
                if (e.target.checked === true) {
                    $('#txtPCOthers').show();
                }
                else {
                    $('#txtPCOthers').hide();
                    $('#txtPCOthers').val('');

                }
            });

            $('#chkInvest').click(function (e) {
                if (e.target.checked === true) {
                    $('#txtInvest').show();
                }
                else {
                    $('#txtInvest').hide();
                    $('#txtInvest').val('');

                }
            });

            $('#chkPerOthers').click(function (e) {
                if (e.target.checked === true) {
                    $('#txtPerOthers').show();
                }
                else {
                    $('#txtPerOthers').hide();
                    $('#txtPerOthers').val('');

                }
            });
            $('#chkPerMedOthers').click(function (e) {
                if (e.target.checked === true) {
                    $('#txtPerMedOthers').show();
                }
                else {
                    $('#txtPerMedOthers').hide();
                    $('#txtPerMedOthers').val('');

                }
            });
            $('#divPostMono input:checkbox').click(function (e) {
                if ($('#divPostMono input[type=checkbox]:checked').length > 1) {
                    $('#divPostMono input:checkbox').prop('checked', false);
                    $(this).prop('checked', true);
                }
            });
            $('#divMarridYN input:checkbox').click(function (e) {
                if ($('#divMarridYN input[type=checkbox]:checked').length > 1) {
                    $('#divMarridYN input:checkbox').prop('checked', false);
                    $(this).prop('checked', true);
                }
                $('.NulliParaUnHide').hide();
                $('.MarriedHide').hide();
                $('.MarriedUnhide').hide();
                $('.MarriedHide input[type=checkbox]').prop('checked', false);
                $('.MarriedHide input[type=text]').val('');
                $('.MarriedUnhide input[type=checkbox]').prop('checked', false);
                $('.NulliParaUnHide input[type=checkbox]').prop('checked', false);
                if (e.target.id === "chkOMarrideYes") {
                    if (e.target.checked) {
                        $('.NulliParaUnHide').show();
                    }
                }


            });
            $('#divNulliPara input:checkbox').click(function (e) {
                if ($('#divNulliPara input[type=checkbox]:checked').length > 1) {
                    $('#divNulliPara input:checkbox').prop('checked', false);
                    $(this).prop('checked', true);
                }

                $('.MarriedHide').hide();
                $('.MarriedUnhide').hide();
                $('.MarriedHide input[type=checkbox]').prop('checked', false);
                $('.MarriedHide input[type=text]').val('');
                $('.MarriedUnhide input[type=checkbox]').prop('checked', false);
                if (e.target.id === "chkONulliparaNo") {
                    if (e.target.checked == true) {
                        $('.MarriedHide').show();
                        $('.MarriedUnhide').show();
                    }

                }

            });
            $('#divNeoAdju input:checkbox').click(function (e) {
                if ($('#divNeoAdju input[type=checkbox]:checked').length > 1) {
                    $('#divNeoAdju input:checkbox').prop('checked', false);
                    $(this).prop('checked', true);
                }
                $('.clNeoAdjDetails').hide();
                $('.clNeoAdjDetails textarea').val('');
                if (e.target.id == "chkTNeoAdjYes") {
                    if (e.target.checked) {
                        $('.clNeoAdjDetails').show();
                    }
                }
            });
            $('#chkONotCarn').click(function (e) {
                $('.MarriedHide').show();
                $('.MarriedHide input[type=checkbox]').prop('checked', false);
                $('.MarriedHide input[type=text]').val('');
                if (e.target.checked) {
                    $('.MarriedHide').hide();
                }
            });

            $('#divAlterMed input:checkbox').click(function (e) {
                if ($('#divAlterMed input[type=checkbox]:checked').length > 1) {
                    $('#divAlterMed input:checkbox').prop('checked', false);
                    $(this).prop('checked', true);
                }
            });
            $('#divEApperance input:checkbox').click(function (e) {
                if ($('#divEApperance input[type=checkbox]:checked').length > 1) {
                    $('#divEApperance input:checkbox').prop('checked', false);
                    $(this).prop('checked', true);
                }
                $('#divEApperOther').hide();
                $('#divEApperOther textarea').val('');
                if (e.target.id == "chkEOthers") {
                    if (e.target.checked) {
                        $('#divEApperOther').show();
                    }
                }
            });
            $('#divEEndoPreAbs input:checkbox').click(function (e) {
                if ($('#divEEndoPreAbs input[type=checkbox]:checked').length > 1) {
                    $('#divEEndoPreAbs input:checkbox').prop('checked', false);
                    $(this).prop('checked', true);
                }
            });

            $('#chkEEndocervical').click(function (e) {

                $('#divEEndoPreAbs').hide();
                $('#divEEndoPreAbs input:checkbox').prop('checked', false);
                if (e.target.checked) {
                    $('#divEEndoPreAbs').show();
                }
            });
            $('#divEFornix input:checkbox').click(function (e) {
                if ($('#divEFornix input[type=checkbox]:checked').length > 1) {
                    $('#divEFornix input:checkbox').prop('checked', false);
                    $(this).prop('checked', true);
                }
            });
            $('#chkEFornix').click(function (e) {

                $('#divEFornix').hide();
                $('#divEFornix input:checkbox').prop('checked', false);
                if (e.target.checked) {
                    $('#divEFornix').show();
                }
            });

            $('#divEVagina input:checkbox').click(function (e) {
                if ($('#divEVagina input[type=checkbox]:checked').length > 1) {
                    $('#divEVagina input:checkbox').prop('checked', false);
                    $(this).prop('checked', true);
                }
            });
            $('#chkEVagina').click(function (e) {

                $('#divEVagina').hide();
                $('#divEVagina input:checkbox').prop('checked', false);
                if (e.target.checked) {
                    $('#divEVagina').show();
                }
            });
            $('#chkENotInvolved').click(function (e) {
                if (e.target.checked) {
                    $('#chkEInvolved').prop('checked', false);
                    $('#divEInvolved').hide();
                    $('#divEInvolved input:checkbox').prop('checked', false);
                    $('#divEILeft').hide();
                    $('#divEIRight').hide();
                }

            });
            $('#chkEInvolved').click(function (e) {
                $('#divEInvolved').hide();
                $('#divEInvolved input:checkbox').prop('checked', false);
                if (e.target.checked) {
                    $('#chkENotInvolved').prop('checked', false);
                    $('#divEILeft').hide();
                    $('#divEIRight').hide();
                    $('#divEInvolved').show();
                }

            });
            $('#chkEPLeft').click(function (e) {
                $('#divEILeft').hide();
                if (e.target.checked) {
                    $('#divEILeft').show();
                }

            });

            $('#divEILeft input:checkbox').click(function (e) {
                if ($('#divEILeft input[type=checkbox]:checked').length > 1) {
                    $('#divEILeft input:checkbox').prop('checked', false);
                    $(this).prop('checked', true);
                }
            });
            $('#divEIRight input:checkbox').click(function (e) {
                if ($('#divEIRight input[type=checkbox]:checked').length > 1) {
                    $('#divEIRight input:checkbox').prop('checked', false);
                    $(this).prop('checked', true);
                }
            });
            $('#divERectum input:checkbox').click(function (e) {
                if ($('#divERectum input[type=checkbox]:checked').length > 1) {
                    $('#divERectum input:checkbox').prop('checked', false);
                    $(this).prop('checked', true);
                }
            });
            $('#divEBleedsontouch input:checkbox').click(function (e) {
                if ($('#divEBleedsontouch input[type=checkbox]:checked').length > 1) {
                    $('#divEBleedsontouch input:checkbox').prop('checked', false);
                    $(this).prop('checked', true);
                }
            });
            $('#divAdvice input:checkbox').click(function (e) {
                if ($('#divAdvice input[type=checkbox]:checked').length > 1) {
                    $('#divAdvice input:checkbox').prop('checked', false);
                    $(this).prop('checked', true);
                }
            });

            $('#divKPSScale input:checkbox').click(function (e) {
                if ($('#divKPSScale input[type=checkbox]:checked').length > 1) {
                    $('#divKPSScale input:checkbox').prop('checked', false);
                    $(this).prop('checked', true);
                }
            });
            $('#divPallor input:checkbox').click(function (e) {
                if ($('#divPallor input[type=checkbox]:checked').length > 1) {
                    $('#divPallor input:checkbox').prop('checked', false);
                    $(this).prop('checked', true);
                }
            });
            $('#divInguinalNode input:checkbox').click(function (e) {
                if ($('#divInguinalNode input[type=checkbox]:checked').length > 1) {
                    $('#divInguinalNode input:checkbox').prop('checked', false);
                    $(this).prop('checked', true);
                }
            });

            $('#chkNAD').click(function (e) {
                $('#txtNADOthers').show();
                $('#txtNADOthers').val('');
                if (e.target.checked) {
                    $('#txtNADOthers').hide();
                }

            });

            $('#chkEPRight').click(function (e) {
                $('#divEIRight').hide();
                if (e.target.checked) {
                    $('#divEIRight').show();
                }

            });

            CreateCompalintGrid();
            BindComplaintGridOnLoad();
            CreateFamilyHistory();
            CreatePersonalGrid();
            CreatePMedicalGrid();
            CreateTreatmentGrid();
            CreateAdviceGrid();
            CreateInvestigation();
            GetComplaintSubLst();
            //ComplaintMainLst();
            // CreateCurTreatmentGrid();
            hideAllDiv();
            $('#tabVital .required input[type=text]').change(function (e) {
                if ($(this)[0].value.trim().length > 0) {
                    $(this).removeClass('ErrorClass');
                }

            });
            $('.clLastVisit').click(function (e) {
                ResetGrid();
                $('#btnSave').hide();
                $('#btnPrint').show();
                $('#btnEdit').hide();
                var tranNo = e.target.parentElement.children[1].innerText;
                var mrNo = $("#spMRNO")[0].textContent;
                $('#spTranNo').text(tranNo);

                var d = new Date();
                var curr_date = d.getDate();
                var curr_month = d.getMonth() + 1;
                var curr_year = d.getFullYear();
                var currentDT = curr_date + "/" + "0" + curr_month + "/" + curr_year;
                var selectedDT = e.target.parentElement.children[0].innerText;
                if (selectedDT == currentDT) {
                    $('#btnEdit').show();
                }


                $('#spTranDt').text(e.target.parentElement.children[0].innerText);
                $('#spTranTM').text(e.target.parentElement.children[2].innerText);

                $.loader.open();
                $.ajax({
                    url: "<%=Url.Action("GetTranData", "DoctorDesk")%>",
                    type: 'post',
                    data: { TranNo: tranNo, MRNo: mrNo, DoctorCode: DoctorCode },
                    datatype: 'json',
                    success: function (result) {

                        if (result.Status == "Failed") {
                            $.loader.close();
                            $.messager.alert("Information", result.Result);

                        } else {

                            BindPatTranData(result.PatHeadData, result.PatCatgNm)
                            var Complaint = JSON.parse(result.PresComp);
                            BindComplaintGrid(Complaint);
                            var PerAddictData = JSON.parse(result.PerAddict);
                            BindPerAddictGrid(PerAddictData);
                            var PerMedData = JSON.parse(result.PerMedical);
                            BindPerMedGrid(PerMedData);
                            var TreatData = JSON.parse(result.Treatment);
                            BindTreatGrid(TreatData);
                            var FamilyData = JSON.parse(result.FamilyHst);
                            BindFamilyGrid(FamilyData);
                            var InvestData = JSON.parse(result.Invest);
                            BindInvestGrid(InvestData);
                            var NotesData = JSON.parse(result.Notes);
                            BindNotesGrid(NotesData);
                           <%-- var canvas = document.getElementById("canOnExam");
                            if (result.ExamImgSrc.trim()) {
                                drawImage(canvas, "data:image/png;base64," + result.ExamImgSrc);
                            }
                            else {
                                drawImage(canvas, "<%=ResolveUrl("~/Images/CervixTemp.jpg")%>");
                        }--%>

                            EnableDisable(true);

                            $.loader.close();
                        }

                    },
                    error: function (xhr, textStatus, errorThrown) {

                        alert(textStatus);
                    }

                });
            });

            $('#lnkNew').click(function (e) {

                $('#btnSave').show();
                $('#btnPrint').hide();
                $('#btnEdit').hide();
                $('#divDoctName').show();
                $('#divPatCatg').show();
                $('#divOldPatCatg').show();
                $('#divOldDoctName').show();
                EnableDisable(false);
                ResetAll();
                //var canvas = document.getElementById("canOnExam");
                // drawImage(canvas, "<%=ResolveUrl("~/Images/CervixTemp.jpg")%>");


                //when new btn click the display new transaction
                if ('<%=Session["strConsNo"]%>' != "" && '<%=Session["StrConsDT"]%>' != "") {
                    $.loader.open();
                    $.ajax({
                        url: '../DoctorDesk/GotoPatientEntry',
                        type: 'post',
                        dataType: 'json',
                        data: 'strConsNo=' + '<%=Session["strConsNo"]%>' + '&StrTranNo=' + "" + '&StrConsDT=' + '<%=Session["StrConsDT"]%>',

                        success: function (result) {
                            $.loader.close();

                            if (result.Status == "Failed") {
                                $.messager.alert("Information", result.Message);
                            }
                            else {
                                window.location.href = result.Message;
                            }
                        },
                        error: function (xhr, textStatus, errorThrown) {

                            $.loader.close();
                        }

                    });

                }
                else {
                    $.messager.alert("Information", "New Record Does Not Available !");
                }
                //end
            });

            $('#btnPrint').click(function (e) {
                var lenghth = $(".edit-cell > *").length;
                for (var i = 0; i < lenghth; i++) {
                    e = jQuery.Event("keydown");
                    e.keyCode = $.ui.keyCode.ENTER;
                    edit = $(".edit-cell > *");
                    edit.trigger(e);
                }
                var Html = PrintData($('#spTranNo').text(), $('#spTranDt').text(), $('#spTranTM').text());
                //    var AgeGender = $('#spAge').text() + " / " + $('#spGender').text();

                //    var doctName = "";
                //    if ($('#btnSave').is(":visible")) {
                //        doctName = $('#spDoctName').text();
                //    }
                //    else {
                //        doctName = $('#spOldDoct').text();
                //    }

                //    var TranDT = $('#spTranDt').text();

                //    var Phone = $('#spMobile').text();

                //    var strVOther = "";
                //    if ($('#txtVitalOthers').val().trim() !== "") {
                //        strVOther = " , Others : " + $('#txtVitalOthers').val().trim()
                //    }
                //    var vitals = " Weight : " + $('#txtWeight').val() + " Lbs " + ", Height : " + $('#txtHeight').val()
                //       + " in "+", Temp : " + $('#txtTemp').val() + " , "+"Pulse : " + $('#txtPulse').val()

                //    var urls = 'PrintPatientReport';
                //    $.ajax({
                //        type: "POST",
                //        url: urls,
                //        data: { AgeGender: AgeGender, doctName: doctName, TranDT: TranDT, Phone: Phone, vitals: vitals },
                //        async: false,
                //        dataType: "json",
                //        success: function (response) {
                //           // ajaxindicatorstop();
                //        }, onerror: function (XMLHttpRequest, textStatus, errorThrown) {
                //         //   MsgDia(textStatus, "Error Information");
                //           // ajaxindicatorstop();
                //        }
                //    });
                //    window.open('DisplayPatientReport', '_blank');
                ////    ajaxindicatorstop();




                PrintListAJAXCommon('<%:Url.Action("PrintPatientReport","DoctorDesk")%>', { strHtml: Html }, $('#spPatName').text(), "");

                //  $.loader.close();
            });
            $('#mdPrint').on('hidden.bs.modal', function (e) {
                $('#myIframe').remove();
                if (gRedirecturl !== "") {
                    window.location.href = gRedirecturl;
                }
                $.loader.close();
            });

            $("#gvComplaints tr").delegate('.subGridchk', "click", function (e) {
                if ($(this).find('input').prop('checked')) {
                    $('#gvComplaints').expandSubGridRow($(this).closest('tr').attr('id'));
                }
                else {
                    $('#gvComplaints').collapseSubGridRow($(this).closest('tr').attr('id'));
                }

            });

            $('input:radio[name="grp"]').change(function () {
                if ($(this).val() == 'main') {

                    document.getElementById("ComboCont").style.visibility = "hidden";
                } else {
                    document.getElementById("ComboCont").style.visibility = "visible";
                }
            });

            if ($("#spTRANMODE")[0].textContent == "2") {
                ResetGrid();
                $('#btnSave').val("Update");
                $('#btnEdit').show();
                $('#btnSave').hide();
                $('#btnPrint').show();
                var tranNo = $("#spTranNo")[0].textContent;// e.target.parentElement.children[1].innerText;
                var mrNo = $("#spMRNO")[0].textContent;
                $('#spTranNo').text(tranNo);


                $.loader.open();
                $.ajax({
                    url: "<%=Url.Action("GetTranData", "DoctorDesk")%>",
                    type: 'post',
                    data: { TranNo: tranNo, MRNo: mrNo, DoctorCode: DoctorCode },
                    datatype: 'json',
                    success: function (result) {

                        if (result.Status == "Failed") {
                            $.loader.close();
                            $.messager.alert("Information", result.Result);

                        } else {

                            BindPatTranData(result.PatHeadData, result.PatCatgNm)
                            var Complaint = JSON.parse(result.PresComp);
                            BindComplaintGrid(Complaint);
                            var PerAddictData = JSON.parse(result.PerAddict);
                            BindPerAddictGrid(PerAddictData);
                            var PerMedData = JSON.parse(result.PerMedical);
                            BindPerMedGrid(PerMedData);
                            var TreatData = JSON.parse(result.Treatment);
                            BindTreatGrid(TreatData);
                            var FamilyData = JSON.parse(result.FamilyHst);
                            BindFamilyGrid(FamilyData);
                            var InvestData = JSON.parse(result.Invest);
                            BindInvestGrid(InvestData);
                            var NotesData = JSON.parse(result.Notes);
                            BindNotesGrid(NotesData);
                            var TreatmentRecData = JSON.parse(result.TreatmentRec);
                            BindTreatmentRecGrid(TreatmentRecData);

                           <%-- var canvas = document.getElementById("canOnExam");
                            if (result.ExamImgSrc.trim()) {
                                drawImage(canvas, "data:image/png;base64," + result.ExamImgSrc);
                            }
                            else {
                                drawImage(canvas, "<%=ResolveUrl("~/Images/CervixTemp.jpg")%>");
                        }--%>

                            // EnableDisable(false);
                            EnableDisable(true);
                            $.loader.close();
                        }

                    },
                    error: function (xhr, textStatus, errorThrown) {

                        alert(textStatus);
                    }

                });


            }
            else if ($("#spTRANMODE")[0].textContent == "3") {
                // $('.clLastVisit').click();


                ResetGrid();
                $('#btnSave').hide();
                $('#btnPrint').show();
                var tranNo = $("#spTranNo")[0].textContent;
                var mrNo = $("#spMRNO")[0].textContent;
                //var tranNo = e.target.parentElement.children[1].innerText;
                $('#spTranNo').text(tranNo);
                //$('#spTranDt').text(e.target.parentElement.children[0].innerText);
                //$('#spTranTM').text(e.target.parentElement.children[2].innerText);

                $.loader.open();
                $.ajax({
                    url: "<%=Url.Action("GetTranData", "DoctorDesk")%>",
                    type: 'post',
                    data: { TranNo: tranNo, MRNo: mrNo, DoctorCode: DoctorCode },
                    datatype: 'json',
                    success: function (result) {

                        if (result.Status == "Failed") {
                            $.loader.close();
                            $.messager.alert("Information", result.Result);

                        } else {

                            BindPatTranData(result.PatHeadData, result.PatCatgNm)
                            var Complaint = JSON.parse(result.PresComp);
                            BindComplaintGrid(Complaint);
                            var PerAddictData = JSON.parse(result.PerAddict);
                            BindPerAddictGrid(PerAddictData);
                            var PerMedData = JSON.parse(result.PerMedical);
                            BindPerMedGrid(PerMedData);
                            var TreatData = JSON.parse(result.Treatment);
                            BindTreatGrid(TreatData);
                            var FamilyData = JSON.parse(result.FamilyHst);
                            BindFamilyGrid(FamilyData);
                            var InvestData = JSON.parse(result.Invest);
                            BindInvestGrid(InvestData);
                            var NotesData = JSON.parse(result.Notes);
                            BindNotesGrid(NotesData);
                            var TreatmentRecData = JSON.parse(result.TreatmentRec);
                            BindTreatmentRecGrid(TreatmentRecData);
                        <%--var canvas = document.getElementById("canOnExam");
                        if (result.ExamImgSrc.trim()) {
                            drawImage(canvas, "data:image/png;base64," + result.ExamImgSrc);
                        }
                        else {
                            drawImage(canvas, "<%=ResolveUrl("~/Images/CervixTemp.jpg")%>");
                        }--%>

                            EnableDisable(true);

                            $.loader.close();
                        }

                    },
                    error: function (xhr, textStatus, errorThrown) {

                        alert(textStatus);
                    }

                });
            }

            $('#btnEdit').click(function (e) {
                $('#btnEdit').hide();
                $('#btnPrint').hide();
                $('#btnSave').show();
                if ($("#spTRANMODE")[0].textContent != "1") {
                    EnableDisable(false);
                }

            });

        });

    //bind complaint grid on load
    function BindComplaintGridOnLoad() {
        $.loader.open();
        $.ajax({
            url: '../DoctorDesk/GetMainCompList',
            type: 'post',
            // data: ,
            datatype: 'json',
            success: function (result) {

                if (result.Status == "Failed") {
                    $.loader.close();
                    $.messager.alert("Information", result.Result);

                } else {
                    $('#gvComplaints').clearGridData();
                    $('#gvComplaints').setGridParam({ data: result.rows }).trigger('reloadGrid');
                    $.loader.close();
                }

            },
            error: function (xhr, textStatus, errorThrown) {

                alert(textStatus);
            }

        });
    }
    //end

    //bind Show test result grid on click
    function TestResultGridDetails() {

        function getColumnIndexByName(grid, columnName) {
            var cm = grid.jqGrid('getGridParam', 'colModel'), i, l = cm.length;
            for (i = 0; i < l; i++) {
                if (cm[i].name === columnName) {
                    return i; // return the index
                }
            }
            return -1;
        }
        colnames = ['Result No', 'Result Date/Time', 'Test Name', 'Investigation', 'Result']
        //var Data = [{ SEL: false, ResultNo: "10000225", ResultDate: "20/06/2017 10:10", TestName: "BUN", InvestName: "E.C.G", Result: "10" }, { SEL: false, ResultNo: "10000226", ResultDate: "22/06/2017 11:10", TestName: "CREATININE", InvestName: "3D Echo", Result: "0.5" }]
        //jQuery("#gridR").jqGrid('destroyFrozenColumns');
        $("#gvShwTRslt").clearGridData();

        jQuery("#gvShwTRslt").jqGrid({
            // url: urlq,
            datatype: 'local',
            //data: Data,
            // mtype: 'post',
            colNames: colnames,

            colModel: [
             { name: 'ResultNo', index: 'ResultNo', width: 110, align: "left", editable: false, frozen: true, searchoptions: { clearSearch: false } },
           { name: 'ResultDate', index: 'ResultDate', width: 140, align: "left", editable: false, frozen: true, searchoptions: { clearSearch: false } },
            //{ name: 'ResultTime', index: 'ResultTime', width: 70, align: "left", editable: false, frozen: true, searchoptions: { clearSearch: false } },
            { name: 'TestName', index: 'TestName', width: 200, editable: false, searchoptions: { clearSearch: false } },

         { name: 'InvestName', index: 'InvestName', width: 200, align: "left", editable: false, frozen: true, searchoptions: { clearSearch: false } },

             { name: 'Result', index: 'Result', width: 100, editable: false, searchoptions: { clearSearch: false } },
            ],

            sortname: 'id',
            sortorder: "desc",
            shrinkToFit: false,
            forceFit: false,
            cellEdit: false,
            cellsubmit: 'clientArray',
            loadonce: true,
            footerrow: false,
            rownumbers: true,
            rowNum: 99999999,
            width: 780,//856
            height: 353,// 353,
            ignoreCase: true,
            ondblClickRow: true,
            scrollerbar: true,
            loadtext: 'Loading...',
            gridComplete: function () {
            },
            gridComplete: function () { //set first row cursor point
                var top_rowid = $('#gvShwTRslt tr:nth-child(2)').attr('id');
                $("#gvShwTRslt").setSelection(top_rowid, true).focus();
            },//end
            loadComplete: function () {
                $('#txtsrchFromDt').val("");
                $('#txtsrchToDt').val("");
                $('#ddlTestlst').val("---Select---");


                if ($('#gvShwTRslt').jqGrid('getGridParam', 'reccount') == 0)
                    $(".jqgfirstrow").css("height", "1px");
                var gridScroll = $('div.ui-jqgrid-bdiv');
                var header = $('.ui-jqgrid-hdiv');
                gridScroll[0].scrollLeft = header[0].scrollLeft;
                if (PGLoadYN == "Y") {

                }
                if (PGLoadYN == "N") {
                    var countgd = jQuery("#gvShwTRslt").jqGrid('getGridParam', 'reccount'); if (countgd == 0) {

                        $("#btnClose").click();//CLOSE DIALOG BOX
                        $('#MDFTR').css('display', 'none');
                        $.messager.alert("Information", "No data for display.");

                        if (searchGDYN == "Y") {
                        }
                        else {
                            $("#gvShwTRslt").clearGridData();
                        }
                    }
                }
                //calculateFooterAmt();
            },
        }).trigger("reloadGrid");
        jQuery("#gvShwTRslt").jqGrid('bindKeys');//up down key
        $("#gvShwTRslt").jqGrid('filterToolbar', {
            searchOnEnter: false,
            ignoreCase: true,
            searchOperators: false,
            defaultSearch: "cn",
            beforeSearch: function () { searchGDYN = "Y"; }
        });

        $('.ui-jqgrid-sdiv').removeClass('ui-widget-content');
        $('.ui-jqgrid-sdiv').addClass('AddFooterClass');

        fixSearchOperators();
        jQuery('#gvShwTRslt').closest('.ui-jqgrid-view')
         .find(".ui-jqgrid-htable .ui-search-toolbar .ui-th-column")
         .find("input, select")
         .focus(function (e) {
             var $header = $(e.target).closest('.ui-jqgrid-hdiv'),
                 $body = $header.siblings('.ui-jqgrid-bdiv');

             setTimeout(function () {

                 $body[0].scrollLeft = $header[0].scrollLeft;
             }, 0);

         });
    }

    function fixSearchOperators() {
        var $grid = $("#gvShwTRslt"),
        columns = $grid.jqGrid('getGridParam', 'colModel'),
        filterToolbar = $($grid[0].grid.headers).find("tr.ui-search-toolbar");
        filterToolbar.find("th").each(function (index) {
            var $searchOper = $(this).find(".ui-search-oper");
            if (!(columns[index].searchoptions && columns[index].searchoptions.searchOperators)) {
                $searchOper.hide();
            }
        });
    }

    function RSearch() {
        var varTestName = "";
        var sfrom = "";
        var sto = "";
        PGLoadYN = "N";
        searchGDYN = "N";

        var sdF = ("" + document.getElementById("txtsrchFromDt").value);
        var sdT = ("" + document.getElementById("txtsrchToDt").value);
        var dateFrm;
        var dateTo;
        if (sdF.length == 10) {
            dateFrm = new Date(parseInt(sdF.substr(6, 4)), parseInt(sdF.substr(3, 2)) - 1, parseInt(sdF.substr(0, 2)));
        }
        if (sdT.length == 10) {
            dateTo = new Date(parseInt(sdT.substr(6, 4)), parseInt(sdT.substr(3, 2)) - 1, parseInt(sdT.substr(0, 2)));
        }

        if (dateFrm !== "" && dateTo != "") {
            if (dateFrm > dateTo) {
                $.messager.alert("Information", "Please Select Valid From Date");
                $('#txtsrchFromDt').datepicker('setDate', 'today');
                $('#txtsrchToDt').datepicker('setDate', 'today');
                return;
            }
        }

        sfrom = ("" + document.getElementById("txtsrchFromDt").value);
        sto = ("" + document.getElementById("txtsrchToDt").value);

        if (sfrom.trim() == '') {
            sto = sfrom;
        }

        varTestName = ("" + $('#ddlTestlst').val());

        //varTestName = ("" + $('#ddlTestlst option:selected').text());
        if (varTestName == "null") {
            varTestName = "";
        }
        //--- For getting Search Criteria for print 
        SearchCriData = "";
        //   if (varDept != "" || ReportType != "S") {
        $("#gvShwTRslt").clearGridData();
        var urlq = '../DoctorDesk/BindTestResultList?FromDate=' + sfrom + '&&ToDate=' + sto + '&&TestName=' + varTestName;
        $("#gvShwTRslt").jqGrid('setGridParam', { url: urlq, datatype: 'json', mtype: 'POST' }).trigger('reloadGrid');

    }
    //end


    function BtnSearchEnt() {
        if (event.keyCode == 13) { $('#btnICDSearch').trigger('click'); }
    }

    function PrintListAJAXCommon(Url, data, fileName, dispurl) {
        // mapForm.submit()
        $.loader.open();
        var oReq = new XMLHttpRequest();
        oReq.open("post", Url, true);
        oReq.responseType = "blob";
        oReq.onload = function (oEvent) {
            var blob = oReq.response;
            var imgSrc = URL.createObjectURL(blob);

            link = document.createElement('a');
            link.id = 'lnktest';
            link.href = imgSrc;
            link.download = 'file.pdf';

            // link.dispatchEvent(new MouseEvent('click'));
            var $iframe = $('<iframe id="myIframe"   name="myIframe" src=' + imgSrc + '#page=2" style=width:100%;height:100%>' +
                 '</iframe>')

            $('#PrintLabel').text($('#spPatName').text());
            $('#iframe').append($iframe);

            $("#myIframe").load(function () {
                gRedirecturl = dispurl;
                $('#mdPrint').modal('show')

                //window.URL.revokeObjectURL(imgSrc);
            });



        };
        var fdata = new FormData();
        fdata.append('strHtml', data.strHtml);
        oReq.send(fdata);


        //var mapForm = document.createElement("form");
        //mapForm.method = "POST";
        //mapForm.action = Url;
        //mapForm.target = 'myIframe'
        //// Create an input
        //for (var i = 0; i < Object.keys(data).length; i++) {
        //    var key = Object.keys(data)[i];
        //    var mapInput = document.createElement("input");
        //    mapInput.type = "text";
        //    mapInput.name = key;
        //    mapInput.value = data[key];
        //    // Add the input to the form
        //    mapForm.appendChild(mapInput);

        //}

        //var $iframe = $('<iframe id="myIframe"  name="myIframe" src="" style=width:100%;height:100%></iframe>')

        //$('#PrintLabel').text($('#spPatName').text());
        //$('#iframe').append($iframe);
        //document.body.appendChild(mapForm);
        //mapForm.submit();

        //setTimeout(function () {

        //}, 1);
        //$("#myIframe").load(function () {
        //    gRedirecturl = dispurl;
        //    $('#mdPrint').modal('show')
        //    document.body.removeChild(mapForm);
        //});



    }

    function EnableDisable(flag) {
        $('.CurrentTabContent input').prop('readonly', flag);
        $('.CurrentTabContent textarea').prop('readonly', flag);
        $('.CurrentTabContent input:checkbox').prop('disabled', flag);
        $('.CurrentTabContent select').prop('disabled', flag);
        $('.Date').prop('disabled', flag);
    }
    function drawImage(canvas, src) {
        var isMobile = window.matchMedia("only screen and (max-width: 760px)");
        var divideval = 2;
        if (isMobile.matches) {
            divideval = 1;
        }
        ctx = canvas.getContext("2d");

        // ctx.fillRect(0, 0, 600, 600);
        var img = new Image();

        img.onload = function () {
            var divRect = document.getElementById("divCanvasExam").getBoundingClientRect()
            if (gcanwidth == 0) {
                canvas.width = ($('.CanvasContent')[0].getBoundingClientRect().width / divideval) - 10;
                gcanwidth = canvas.width;
            }
            else {
                canvas.width = gcanwidth;
            }
            if (gcanheight == 0) {
                canvas.height = ($('.CanvasContent')[0].getBoundingClientRect().bottom - $('.CanvasContent')[0].getBoundingClientRect().top) - 30;
                gcanheight = canvas.height;
            }
            else {
                canvas.height = gcanheight;
            }

            ctx.clearRect(0, 0, canvas.width, canvas.height);

            ctx.drawImage(img, 0, 0, img.width, img.height, 0, 0, canvas.width, canvas.height);
        }

        img.src = src;
    }
    function hideAllDiv() {

        $('#divBiopsy').hide();
        $('#divAbdomen').hide();
        $('#divMRI').hide();
        $('#divHIV').hide();
        $('#divHBsAg').hide();
        $('#divCreatinine').hide();
        $('#divCBC').hide();
        $('#divXray').hide();
        $('#divColonoscopy').hide();
        $('#divCystoscopy').hide();
        $('#txtBiOthers').hide();
        $('#txtHNPSize').hide();
        $('#txtHNPSite').hide();
        $('#txtMHNPSize').hide();
        $('#txtMHNPSite').hide();
        //$('#divBInvolve').hide();
        //$('#divRInvolve').hide();
        $('#divNotePresent').hide();
        $('#divMNotePresent').hide();
        //$('#divInvestNote').hide();
        //$('#divHydronePresAbs').hide();
        $('#divHydronePresent').hide();
        $('#divHydroneRightPresent').hide();
        $('#divHydroneLeftPresent').hide();
        $('#divMHydronePresent').hide();
        $('#divMHydroneRightPresent').hide();
        $('#divMHydroneLeftPresent').hide();
        $('#divXrayOther').hide();
        $('#txtPCOthers').hide();
        $('#txtInvest').hide();
        $('#txtPerMedOthers').hide();
        $('#txtPerOthers').hide();
        $('.clNeoAdjDetails').hide();
        $('.NulliParaUnHide').hide();
        $('.MarriedHide').hide();
        $('.MarriedUnhide').hide();
        $('#divEApperOther').hide();
        $('#divEEndoPreAbs').hide();
        $('#divEVagina').hide();
        $('#divEFornix').hide();
        $('#divEInvolved').hide();

        $('#divEILeft').hide();
        $('#divEIRight').hide();

        $('#divOldDoctName').hide();
        $('#divOldPatCatg').hide();

    }

    var grep1 = "";
    function CreateCompalintGrid() {
        $("#gvComplaints").jqGrid('GridUnload');
        var SubColName = new Array();
        var ColName = new Array();
        var ColModel = new Array();
        var subModel = new Array();
        var increment = 0;
        ColName.push(" ");
        ColModel.push({
            name: "CHECK", index: "CHECK", width: 40, editable: false,
            align: 'center',
            edittype: 'checkbox',
            sortable: true,
            formatter: "checkbox", formatoptions: { disabled: false },
            editoptions: { size: 39, value: "True:False" },
            classes: 'subGridchk'
        })
        ColName.push("DESCCD");
        ColModel.push({ name: "DESCCD", index: "DESCCD", width: 400, key: true, sortable: false, hidden: true })
        ColName.push("Description");
        ColModel.push({ name: "DESC", index: "DESC", width: 400, sortable: false, editable: true, cellattr: function () { return ' class="not-editable-cell"'; } })
        ColName.push(" ");
        ColModel.push({
            name: "DURATION", index: "DURATION", width: 100, sortable: false,
            align: 'center',
            editable: true,
            cellEdit: true,
            edittype: 'select',
            formatter: 'select',
            editoptions: {
                value: YearData,
                dataInit: function (element) {
                    $(element).select2({ width: '100px', containerCssClass: "bigdrop" }).on("select2:close", function (e) {
                        $("#gvComplaints").jqGrid("saveCell", saverow, savecol);
                    })


                }
            }
        });
        ColName.push(" ");
        ColModel.push({
            name: 'DURTYPE', index: 'DURTYPE', width: 100,
            sortable: false,
            align: 'center',
            editable: true,
            cellEdit: true,
            edittype: 'select',
            formatter: 'select',
            editoptions: {
                value: gDurType,
                dataInit: function (element) {
                    $(element).select2({ width: '100px', containerCssClass: "bigdrop" }).on("select2:close", function (e) {
                        $("#gvComplaints").jqGrid("saveCell", saverow, savecol);
                    })
                    // $(element).width(122).select2('open');

                }
            }
        });

        subModel = ColModel.concat();

        subModel.push({ name: "REMARKS", index: "REMARKS", width: 350, editable: true, sortable: false, editoptions: { maxlength: 500 } })

        ColName.push("Remarks");
        ColModel.push({ name: "REMARKS", index: "REMARKS", width: 450, editable: true, sortable: false, editoptions: { maxlength: 500 } })


        SubColName = ColName.concat();
        SubColName.push("GRPCD");
        subModel.push({ name: "GRPCD", index: "GRPCD", width: 400, key: true, sortable: false, hidden: true })

        $('#gvComplaints').jqGrid({
            // url: '../DoctorDesk/GetMainCompList',
            //  datatype: 'json', //mtype: 'post',
            datatype: 'local',
            //data: gPreCompdata,

            colNames: ColName,
            colModel: ColModel,
            loadtext: "Loading...",
            cellEdit: true,
            cellsubmit: 'clientArray',
            sortorder: 'desc',
            sortname: 'CHECK',
            shrinkToFit: false,
            rowNum: 999999999999,
            width: $('#gbox_gvComplaints').parent().width(),
            height: 220,
            autoencode: true,
            sortname: "matter",
            loadonce: true,
            sortable: true,
            ignoreCase: true,
            beforeSelectRow: function (rowid, e) {
                //if (e.currentTarget.checked == false)
                //{

                //}
                if (!$('#btnSave').is(":visible")) {
                    return false;
                }
                //$("#gvComplaints tr").removeClass('ui-state-hover');
                //$("#gvComplaints").resetSelection();
                var result = $(e.target).closest("tr").children('td').children('input')[0].checked;
                if (result == false) {
                    $(e.target).closest("tr").children('td').children('input')[0].checked == false;
                    $(e.target).closest("tr").children('td').children('input')[0].value == false;
                    //  $('#gvComplaints').collapseSubGridRow($(e.target).closest('tr').attr('id'));
                    $('#gvComplaints').collapseSubGridRow($(e.target).closest('tr').attr('id'));


                    if (complArrdata.length > 0) {

                        $('#gvComplaints').jqGrid('setCell', rowid, 'DURATION', " ")
                        $('#gvComplaints').jqGrid('setCell', rowid, 'DURTYPE', " ")
                        $('#gvComplaints').jqGrid('setCell', rowid, 'REMARKS', " ")

                        jQuery('#gvComplaints').setRowData(rowid, '', { 'background-color': '' });//selected row set bgcolor

                        var i = complArrdata.indexOf(rowid);
                        complArrdata.pop(i);//remove rowid from array when unchecked
                        complArrdata2[0].pop(i);
                    }
                }
                else {
                    $('#gvComplaints').expandSubGridRow($(this).closest('tr').attr('id'));
                    if (gPreSubCompdata != undefined) {
                        new_arr = $.grep(gPreSubCompdata, function (n, i) { // just use arr
                            //  $('#gvComplaints').collapseSubGridRow($(e.target).closest('tr').attr('id'));
                            return n.GRPCD == $(e.target).closest('tr').attr('id');
                        });
                        if (new_arr.length > 0) {
                            $('#gvComplaints').expandSubGridRow($(e.target).closest('tr').attr('id'));
                        }
                    }


                    if (complArrdata.length > 0) {
                        var a = complArrdata.indexOf(rowid);
                        if (complArrdata[a] == rowid) {

                        }
                        else {
                            complArrdata.push(rowid);//add rowid in array when checked
                            jQuery('#gvComplaints').setRowData(rowid, '', { 'background-color': '#b2ffb2' });//selected row set bgcolor #FF6F6F
                        }
                    }
                    else {
                        complArrdata.push(rowid);//add rowid in array when checked
                        jQuery('#gvComplaints').setRowData(rowid, '', { 'background-color': '#b2ffb2' });//selected row set bgcolor #FF6F6F
                    }

                }

                return result;

            },
            afterSaveCell: function (rowid, name, val, iRow, iCol) {
                if (complArrdata.length > 0) {
                    var a = complArrdata.indexOf(rowid);
                    if (complArrdata[a] == rowid) {
                        var selComplaintDat = $.grep($('#gvComplaints').getRowData(), function (e) { return e.CHECK == 'True' });
                        complArrdata2 = new Array();
                        complArrdata2.push(selComplaintDat);
                    }
                    else {
                        complArrdata.push(rowid);//add rowid in array when checked
                        jQuery('#gvComplaints').setRowData(rowid, '', { 'background-color': '#b2ffb2' });//selected row set bgcolor #FF6F6F

                        var selComplaintDat = $.grep($('#gvComplaints').getRowData(), function (e) { return e.CHECK == 'True' });
                        complArrdata2.push(selComplaintDat);
                    }
                }
                else {
                    complArrdata.push(rowid);//add rowid in array when checked
                    jQuery('#gvComplaints').setRowData(rowid, '', { 'background-color': '#b2ffb2' });//selected row set bgcolor #FF6F6F

                    var selComplaintDat = $.grep($('#gvComplaints').getRowData(), function (e) { return e.CHECK == 'True' });
                    complArrdata2.push(selComplaintDat);
                }
            },
            afterEditCell: function (id, name, val, iRow, iCol) {
                if (name == "REMARKS") {
                    $("#" + iRow + "_" + name).bind('blur', function (e) {
                        $('#gvComplaints').saveCell(iRow, iCol);

                    });
                }
                saverow = iRow;
                savecol = iCol;

            },

            loadComplete: function () {
                if (complArrdata2.length > 0) {
                    for (i = 0; i < complArrdata2[0].length; i++) {
                        $("#gvComplaints").jqGrid("setCell", complArrdata2[0][i].DESCCD, "CHECK", true);
                        $("#gvComplaints").jqGrid("setCell", complArrdata2[0][i].DESCCD, "DURATION", complArrdata2[0][i].DURATION);
                        $("#gvComplaints").jqGrid("setCell", complArrdata2[0][i].DESCCD, "DURTYPE", complArrdata2[0][i].DURTYPE);
                        $("#gvComplaints").jqGrid("setCell", complArrdata2[0][i].DESCCD, "REMARKS", complArrdata2[0][i].REMARKS);
                        jQuery('#gvComplaints').setRowData(complArrdata2[0][i].DESCCD, '', { 'background-color': '#b2ffb2' });//selected row set bgcolor
                    }
                }

                //tranmode 2 or 3 then set bg color here
                for (var i = 0; i <= grep1.length - 1; i++) {
                    var rowid = grep1[i].DESCCD;
                    jQuery('#gvComplaints').setRowData(rowid, '', { 'background-color': '#b2ffb2' });//selected row set bgcolor #FF6F6F
                }

                if ($('#gvComplaints').jqGrid('getGridParam', 'reccount') == 0) {

                    $(".jqgfirstrow").css("height", "1px");
                }
            },

            subGrid: true,
            subGridOptions: { reloadOnExpand: true },
            subGridRowExpanded: function (subgrid_id, row_id) {
                var subgrid_table_id, pager_id;
                subgrid_table_id = subgrid_id + "_per";

                levelTwoTableId = subgrid_table_id;
                pager_id = "p_" + subgrid_table_id;

                new_arr = $.grep(gPreSubCompdata, function (n, i) { // just use arr
                    return n.GRPCD == row_id;
                });

                $("#" + subgrid_id).html("<table id='" + subgrid_table_id + "' class='scroll'></table>");
                // if (new_arr.length > 0) {
                jQuery("#" + subgrid_table_id).jqGrid({
                    datatype: 'local',
                    data: new_arr,
                    colNames: SubColName,
                    colModel: subModel,
                    height: '100%',
                    loadtext: "Loading...",
                    cellEdit: true,
                    cellsubmit: 'clientArray',
                    shrinkToFit: false,
                    loadonce: false,
                    rowNum: 999999999999,
                    width: $('#' + row_id).width(), //$('#gbox_gvComplaints').parent().width() - 80,
                    //autowidth: true,
                    beforeSelectRow: function (rowid, e) {
                        if (!$('#btnSave').is(":visible")) {
                            return false;
                        }
                        //$("#gvComplaints tr").removeClass('ui-state-hover');
                        //$("#gvComplaints").resetSelection();
                        var result = $(e.target).closest("tr").children('td').children('input')[0].checked;
                        if ($(e.target).closest("tr").children('td').children('input')[0].checked == false) {
                            $(e.target).closest("tr").children('td').children('input')[0].checked == false;
                            $(e.target).closest("tr").children('td').children('input')[0].value == false;
                        }
                        else {
                            //$(e.target.closest('tr')).addClass('ui-state-hover');
                            //$("#gvComplaints").jqGrid('setSelection', rowid);
                        }

                        return result;

                    },
                    afterEditCell: function (id, name, val, iRow, iCol) {
                        if (name == "REMARKS") {
                            $("#" + iRow + "_" + name).bind('blur', function (e) {
                                $('#' + subgrid_table_id).saveCell(iRow, iCol);

                            });
                        }

                        saverow = iRow;
                        savecol = iCol;
                    },
                    rowattr: function (rd) {
                        return { "style": "background-color: rgba(245, 105, 23, 0.21);" };
                        //alert("hi");


                    },
                    loadComplete: function () {

                        if ($('#' + subgrid_table_id).jqGrid('getGridParam', 'reccount') == 0) {

                            $(".jqgfirstrow").css("height", "1px");
                        }
                    }
                });

                //$('#' + subgrid_table_id).jqGrid('setGroupHeaders', {
                //    useColSpanStyle: true,
                //    groupHeaders: [
                //      { startColumnName: 'DURATION', numberOfColumns: 2, titleText: 'Duration' },

                //    ]
                //});
                jQuery("#" + subgrid_table_id).closest("div.ui-jqgrid-view")
    .children("div.ui-jqgrid-hdiv")
    .hide();
                //        jQuery("#" + subgrid_table_id).width() = $("#" + row_id).width();
                //    } else {
                //        $('#gvComplaints').collapseSubGridRow(row_id);
                //  }
            }
        })//.trigger("reloadGrid");

        $("#gvComplaints").jqGrid("hideCol", "subgrid");
        $('#gvComplaints').jqGrid('setGroupHeaders', {
            useColSpanStyle: true,
            groupHeaders: [
              { startColumnName: 'DURATION', numberOfColumns: 2, titleText: 'Duration' },

            ]
        });
        jQuery("#gvComplaints").jqGrid('bindKeys');//up down key
        //for search items
        $("#gvComplaints").jqGrid('filterToolbar', {
            searchOnEnter: false, searchOperators: false, defaultSearch: "cn",
        });

    }



    function GetComplaintSubLst() {
        $.ajax({
            type: "GET",
            url: "../DoctorDesk/GetSubCompList",
            async: false,
            datatype: "json",
            success: function (result) {
                gPreSubCompdata = result.rows;
            }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                MsgDia('An error occurred while processing your request.', "Error Information");
            }
        });
        //  $("#gvComplaints").jqGrid('setGridParam', { url: '../Oncology/GetMainCompList', datatype: 'json', mtype: 'POST' }).trigger('reloadGrid');          
    }

    function CreateFamilyHistory() {
        var ColName = new Array();
        var ColModel = new Array();
        var increment = 0;

        ColName.push("Name");
        ColModel.push({ name: "NAME", index: "NAME", width: 220, editable: true, editoptions: { maxlength: 30 } })
        ColName.push("Age");
        ColModel.push({ name: "AGE", index: "AGE", width: 70, editable: true, editoptions: { maxlength: 10 } })
        ColName.push("Relation");
        ColModel.push({
            name: "RELATION", index: "RELATION", width: 100, align: 'center',
            editable: true,
            cellEdit: true,
            edittype: 'select',
            formatter: 'select',
            editoptions: {
                value: gRelation,
                dataInit: function (element) {
                    $(element).select2({ width: '100px', containerCssClass: "bigdrop" }).on("select2:close", function (e) {
                        $("#gvFamily").jqGrid("saveCell", saverow, savecol);
                    })
                    // $(element).width(122).select2('open');

                }
            }
        });

        ColName.push("Status");
        ColModel.push({
            name: "STATUS", index: "STATUS", align: 'center', width: 90,
            editable: true,
            cellEdit: true,
            edittype: 'select',
            formatter: 'select',
            hidden: true,
            visible: false,
            editoptions: {
                value: gDStatus,
                dataInit: function (element) {
                    $(element).select2({ width: '90px', containerCssClass: "bigdrop" }).on("select2:close", function (e) {
                        $("#gvFamily").jqGrid("saveCell", saverow, savecol);
                    })
                    // $(element).width(122).select2('open');

                }
            }
        });

        ColName.push("Diseases");
        ColModel.push({ name: "DISEASES", index: "DISEASES", width: 230, editable: true, sortable: true, editoptions: { maxlength: 100 } })
        ColName.push(" ");
        ColModel.push({
            name: "DURATION", index: "DURATION", width: 60, sortable: false,
            align: 'center',
            editable: true,
            cellEdit: true,
            edittype: 'select',
            formatter: 'select',
            editoptions: {
                value: YearData,
                dataInit: function (element) {
                    $(element).select2({ width: '60px', containerCssClass: "bigdrop" }).on("select2:close", function (e) {
                        $("#gvFamily").jqGrid("saveCell", saverow, savecol);
                    })
                    // $(element).width(122).select2('open');

                }
            }
        });
        ColName.push(" ");
        ColModel.push({
            name: "DURTYPE", index: "DURTYPE", align: 'center', width: 70,
            editable: true,
            cellEdit: true,
            edittype: 'select',
            formatter: 'select',
            editoptions: {
                value: gDurType,
                dataInit: function (element) {
                    $(element).select2({ width: '70px', containerCssClass: "bigdrop" }).on("select2:close", function (e) {
                        $("#gvFamily").jqGrid("saveCell", saverow, savecol);
                    })
                    // $(element).width(122).select2('open');

                }
            }
        });
        ColName.push("Remarks");
        ColModel.push({ name: "REMARKS", index: "REMARKS", width: 250, editable: true, sortable: true, editoptions: { maxlength: 200 } })

        $('#gvFamily').jqGrid({
            datatype: 'local',
            colNames: ColName,
            colModel: ColModel,
            data: gFamilyHis,
            loadtext: "Loading...",
            cellEdit: true,
            cellsubmit: 'clientArray',
            shrinkToFit: false,
            rowNum: 999999999999,
            width: $('#gbox_gvFamily').parent().width(),
            height: 207,
            beforeSelectRow: function (rowid, e) {
                if (!$('#btnSave').is(":visible")) {
                    return false;
                }
                return true;
            },
            afterEditCell: function (id, name, val, iRow, iCol) {
                if (name !== "DURATION" && name !== "DURTYPE" && name !== "RELATION" && name !== "STATUS") {
                    //$("#" + iRow + "_" + name).bind('blur', function (e) {
                    //    $('#gvFamily').saveCell(iRow, iCol);
                    //});
                }
                saverow = iRow;
                savecol = iCol;
            },
            afterSaveCell: function (id, name, val, iRow, iCol) {
                if (name !== "DURATION" && name !== "DURTYPE" && name !== "RELATION" && name !== "STATUS") {
                    //$("#" + iRow + "_" + name).bind('blur', function (e) {
                    //    $('#gvFamily').saveCell(iRow, iCol);
                    //});
                }
                saverow = iRow;
                savecol = iCol;
            },
            loadComplete: function () {
                if ($('#gvFamily').jqGrid('getGridParam', 'reccount') == 0) {

                    $(".jqgfirstrow").css("height", "1px");
                }
                if ($("#spTRANMODE")[0].textContent == "2") {
                    var advisedata = $("#gvFamily").jqGrid('getGridParam', 'data');
                    var a = advisedata.length;
                    if (rowaddedHIS == false) {
                        var myfirstrow = { NAME: "", AGE: "", RELATION: "", STATUS: "", DISEASE: "", DURATION: "", DURTYPE: "", REMARKS: "" };
                        $("#gvFamily").jqGrid("addRowData", Number(a) + 1, myfirstrow);
                        rowaddedHIS = true;
                    }
                    else {
                        if (a != 0) {
                            if (advisedata[advisedata.length - 1].NAME != "") {
                                var myfirstrow = { NAME: "", AGE: "", RELATION: "", STATUS: "", DISEASE: "", DURATION: "", DURTYPE: "", REMARKS: "" };
                                $("#gvFamily").jqGrid("addRowData", Number(a) + 1, myfirstrow);
                            }
                        }
                        else {
                            var myfirstrow = { NAME: "", AGE: "", RELATION: "", STATUS: "", DISEASE: "", DURATION: "", DURTYPE: "", REMARKS: "" };
                            $("#gvFamily").jqGrid("addRowData", Number(a) + 1, myfirstrow);
                        }
                    }

                }
            },
            formatCell: function (rowid, name, val, iRow, iCol) {//afterSaveCell

                if ($("#spTRANMODE")[0].textContent == "2") {
                    var cm = jQuery("#gvFamily").jqGrid("getGridParam", "colModel");
                    if (iCol == 1) {
                        var myfirstrow = { NAME: "", AGE: "", RELATION: "", STATUS: "", DISEASE: "", DURATION: "", DURTYPE: "", REMARKS: "" };
                        var advisedata = $("#gvFamily").jqGrid('getGridParam', 'data');
                        var a = advisedata.length;
                        //for (a <= advisedata.length; ;) {
                        $("#gvFamily").jqGrid("addRowData", Number(a) + 1, myfirstrow);
                        //a = a + 1;
                        //break;
                    }
                }
            },
        }).trigger("reloadGrid");
        $('#gvFamily').jqGrid('setGroupHeaders', {
            useColSpanStyle: true,
            groupHeaders: [
              { startColumnName: 'DURATION', numberOfColumns: 2, titleText: 'Duration' },

            ]
        });
        jQuery("#gvFamily").jqGrid('bindKeys');
    }

    function FillICDInfoUserCntrl(rowData) {
        $('#txtICDNM').attr('disabled', true);
        $('#txtICDCD').attr('disabled', true);
        $("#txtICDCD").val(rowData.ICDCODE);
        $("#txtICDNM").val(rowData.ICDNAME);
    }
    //bind generic usrcontrol
    //function FillGenericInfoUserCntrl2(rowData) {
    //    //var rowdata = $("#gvAdvice").jqGrid('getGridParam', 'data');
    //    // var a = rowdata.length;

    //    var rowIDs = $("#gvAdvice").jqGrid('getDataIDs');

    //    for (var i = 0; i < rowIDs.length; i++) {
    //        var rowId = rowIDs[i];
    //        var rowdata = jQuery('#gvAdvice').jqGrid('getRowData', rowId);
    //        //gvadvice in that drugname and generic set cell here
    //        if (rowdata.DRUGNM == "") {
    //            $("#gvAdvice").jqGrid("setCell", rowIDs[i], "DRUGNM", rowData.DRUGNAME)
    //            $("#gvAdvice").jqGrid("setCell", rowIDs[i], "GENERICNAME", rowData.GENERICNAME)

    //            $("#gvAdvice").jqGrid("setCell", rowIDs[i], "DRUGCD", rowData.DRUGCODE)
    //            $("#gvAdvice").jqGrid("setCell", rowIDs[i], "GENERICID", rowData.GENERICCODE)
    //            if ($("#spTRANMODE")[0].textContent == "2") {

    //                //add new row empty
    //                // var myfirstrow = { RM: '<span class="ui-icon ui-icon-cancel">Remove</span>', DRUGCD: "", GENERICID: "", DRUGFORM: "", GENERICNAME: "", DRUGNM: "", DOSSAGE: "", DAYS: "", INT1: "", INT2: "", INT3: "", INT4: "", ROUTE: "", Remarks: "" };
    //                //$("#gvAdvice").jqGrid("addRowData", rowId + 1, myfirstrow);
    //            }
    //            break;

    //        }
    //    }

    //}

    //bind generic usrcontrol
    function FillGenericInfoUserCntrl(rowData) {
        //var rowdata = $("#gvAdvice").jqGrid('getGridParam', 'data');
        // var a = rowdata.length;


        $.ajax({
            type: "GET",
            url: "../DoctorDesk/GetBrandDetails?refID=" + rowData.DRUGCODE,
            async: false,
            datatype: "json",
            success: function (result) {
                var rowIDs = $("#gvAdvice").jqGrid('getDataIDs');

                for (var i = 0; i < rowIDs.length; i++) {
                    var rowId = rowIDs[i];
                    var rowdata = jQuery('#gvAdvice').jqGrid('getRowData', rowId);
                    //gvadvice in that drugname and generic set cell here
                    if (rowdata.DRUGNM == "") {
                        $("#gvAdvice").jqGrid("setCell", rowId, "DRUGNM", result.rows.DRUGNAME);
                        $("#gvAdvice").jqGrid("setCell", rowId, "GENERICNAME", result.rows.GENERICNAME);
                        $("#gvAdvice").jqGrid("setCell", rowId, "DRUGFORM", result.rows.MTRLFORM.substr(0, 1));
                        //result.rows.MTRLFORM
                        $("#gvAdvice").jqGrid("setCell", rowId, "DRUGCD", "");
                        $("#gvAdvice").jqGrid("setCell", rowId, "GENERICID", "");

                        break;

                    }
                }
            }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                MsgDia('An error occurred while processing your request.', "Error Information");
            }
        });

        //var rowIDs = $("#gvAdvice").jqGrid('getDataIDs');

        //for (var i = 0; i < rowIDs.length; i++) {
        //    var rowId = rowIDs[i];
        //    var rowdata = jQuery('#gvAdvice').jqGrid('getRowData', rowId);
        //    //gvadvice in that drugname and generic set cell here
        //    if (rowdata.DRUGNM == "") {
        //        $("#gvAdvice").jqGrid("setCell", rowIDs[i], "DRUGNM", rowData.DRUGNAME)
        //        $("#gvAdvice").jqGrid("setCell", rowIDs[i], "GENERICNAME", rowData.GENERICNAME)

        //        $("#gvAdvice").jqGrid("setCell", rowIDs[i], "DRUGCD", rowData.DRUGCODE)
        //        $("#gvAdvice").jqGrid("setCell", rowIDs[i], "GENERICID", rowData.GENERICCODE)
        //        if ($("#spTRANMODE")[0].textContent == "2") {

        //            //add new row empty
        //            // var myfirstrow = { RM: '<span class="ui-icon ui-icon-cancel">Remove</span>', DRUGCD: "", GENERICID: "", DRUGFORM: "", GENERICNAME: "", DRUGNM: "", DOSSAGE: "", DAYS: "", INT1: "", INT2: "", INT3: "", INT4: "", ROUTE: "", Remarks: "" };
        //            //$("#gvAdvice").jqGrid("addRowData", rowId + 1, myfirstrow);
        //        }
        //        break;

        //    }
        //}

    }

    function CreatePersonalGrid() {

        var ColName = new Array();
        var ColModel = new Array();
        var increment = 0;
        ColName.push("");
        ColModel.push({
            name: "CHECK", index: "CHECK", width: 40, editable: false,
            align: 'center',
            edittype: 'checkbox',
            sortable: false,
            formatter: "checkbox", formatoptions: { disabled: false },
            editoptions: { size: 39, value: "True:False" }
        });
        ColName.push("Code");
        ColModel.push({ name: "ADDICTCD", index: "ADDICTCD", width: 180, hidden: true, key: true })
        ColName.push("Addiction");
        ColModel.push({ name: "DESC", index: "DESC", width: 180, editable: true, cellattr: cellattr, sortable: false, })
        ColName.push("Starting Age (Years)");
        ColModel.push({
            name: "STARTAGE", index: "STARTAGE", width: 135, editable: true, sortable: false, editoptions: {
                maxlength: 3, dataInit: function (element) {
                    $(element).keypress(function (e) {
                        if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
                            return false;
                        }
                    });
                }
            }
        })
        ColName.push("Stopped at Age (Years)");
        ColModel.push({
            name: "STOPAGE", index: "STOPAGE", width: 155, editable: true, sortable: false, editoptions: {
                maxlength: 3, dataInit: function (element) {
                    $(element).keypress(function (e) {
                        if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
                            return false;
                        }
                    });
                }
            }
        })

        $('#gvPersonal').jqGrid({
            datatype: 'local',
            data: gPersonaldata,
            colNames: ColName,
            colModel: ColModel,
            loadtext: "Loading...",
            cellEdit: true,
            cellsubmit: 'clientArray',
            shrinkToFit: false,
            rowNum: 999999999999,
            width: $('#gbox_gvPersonal').parent().width(),
            height: 160,
            beforeSelectRow: function (rowid, e) {
                if (!$('#btnSave').is(":visible")) {
                    return false;
                }
                $("#gvPersonal tr").removeClass('ui-state-hover');
                $("#gvPersonal").resetSelection();
                var result = false;
                result = $(e.target).closest("tr").children('td').children('input')[0].checked;

                if ($(e.target).closest("tr").children('td').children('input')[0].checked == false) {
                    $(e.target).closest("tr").children('td').children('input')[0].checked == false;
                    $(e.target).closest("tr").children('td').children('input')[0].value == false;
                }
                else {
                    var Latrow = $("#gvPersonal").getRowData('04');
                    if (rowid == "08" && result) {
                        $("#gvPersonal").clearGridData();
                        var localData = gPersonaldata.slice(0);
                        localData[7]["CHECK"] = "True";
                        $("#gvPersonal").setGridParam({ data: gPersonaldata }).trigger('reloadGrid');
                        $('#gvPersonal tr:eq(8)').addClass('ui-state-hover');
                        $("#gvPersonal").jqGrid('setSelection', '08', true);


                    }
                    else if (Latrow["CHECK"] === "True" && rowid != "08") {
                        $("#gvPersonal").getRowData(rowid)["CHECK"] = "True";
                        var localData = $("#gvPersonal").getRowData();
                        localData[7]["CHECK"] = "False";
                        $("#gvPersonal").clearGridData();
                        $("#gvPersonal").setGridParam({ data: localData }).trigger('reloadGrid');
                        $('#gvPersonal tr:eq(' + parseInt(rowid) + ')').addClass('ui-state-hover');

                        $("#gvPersonal").jqGrid('setSelection', rowid);
                    }
                    else {
                        $(e.target.closest('tr')).addClass('ui-state-hover');
                        $("#gvPersonal").jqGrid('setSelection', rowid);
                    }

                    //$(e.target.closest('tr')).addClass('ui-state-hover');
                    //$("#gvPersonal").jqGrid('setSelection', rowid);
                }

                return result;

            },
            afterEditCell: function (id, name, val, iRow, iCol) {
                //jQuery("#gvPersonal").jqGrid('saveRow', lastSel);
                $("#" + iRow + "_" + name).bind('blur', function (e) {
                    $('#gvPersonal').saveCell(iRow, iCol);

                });
            },


            loadComplete: function () {
                if ($('#gvPersonal').jqGrid('getGridParam', 'reccount') == 0) {

                    $(".jqgfirstrow").css("height", "1px");
                }

            }
        }).trigger("reloadGrid");

    }
    function cellattr(rowId, tv, rawObject, cm, rdata) {
        if (rawObject.locked) return ' class="not-editable-cell"';
    };
    //this for Personal Medical Grid
    function CreatePMedicalGrid() {



        var ColName = new Array();
        var ColModel = new Array();
        var increment = 0;
        ColName.push("");
        ColModel.push({
            name: "CHECK", index: "CHECK", width: 40, editable: false,
            align: 'center',
            edittype: 'checkbox',
            sortable: false,
            formatter: "checkbox", formatoptions: { disabled: false },
            editoptions: { size: 39, value: "True:False" }
        })
        ColName.push("MEDCD");
        ColModel.push({ name: "MEDCD", index: "MEDCD", key: true, width: 100, hidden: true });
        ColName.push("Suffering");
        ColModel.push({ name: "DESC", index: "DESC", width: 100, editable: true, sortable: false, cellattr: cellattr });
        ColName.push(" ");
        ColModel.push({
            name: "DURATION", index: "DURATION", width: 100, sortable: false,
            align: 'center',
            editable: true,
            cellEdit: true,
            edittype: 'select',
            formatter: 'select',
            editoptions: {
                value: YearData,
                dataInit: function (element) {
                    $(element).select2({ width: '100px', containerCssClass: "bigdrop" }).on("select2:close", function (e) {
                        $("#gvPersonalMedical").jqGrid("saveCell", saverow, savecol);
                    })

                }
            }
        });
        ColName.push(" ");
        ColModel.push({
            name: 'DURTYPE', index: 'DURTYPE', width: 100,
            sortable: false,
            align: 'center',
            editable: true,
            cellEdit: true,
            edittype: 'select',
            formatter: 'select',
            editoptions: {
                value: gDurType,
                dataInit: function (element) {
                    $(element).select2({ width: '100px', containerCssClass: "bigdrop" }).on("select2:close", function (e) {
                        $("#gvPersonalMedical").jqGrid("saveCell", saverow, savecol);
                    })

                }
            }
        });

        ColName.push("On regular treatment");
        ColModel.push({
            name: 'ONREGTREATYN', index: 'ONREGTREATYN', width: 170,
            sortable: false,
            align: 'center',
            editable: true,
            cellEdit: true,
            edittype: 'text',//select
            //formatter: 'text',
            //editoptions: {
            //    value: { 'N': 'No', 'Y': 'Yes' },
            //    dataInit: function (element) {
            //        $(element).select2({ width: '100px', containerCssClass: "bigdrop" }).on("select2:close", function (e) {
            //            $("#gvPersonalMedical").jqGrid("saveCell", saverow, savecol);
            //        })
            //    }
            //}
        });

        $('#gvPersonalMedical').jqGrid({
            datatype: 'local',
            data: gPerMeddata,
            colNames: ColName,
            colModel: ColModel,
            loadtext: "Loading...",
            cellEdit: true,
            cellsubmit: 'clientArray',
            shrinkToFit: false,
            rowNum: 999999999999,
            width: $('#gbox_gvPersonalMedical').parent().width(),
            height: 140,
            beforeSelectRow: function (rowid, e) {
                if (!$('#btnSave').is(":visible")) {
                    return false;
                }
                //  $("#gvPersonalMedical tr").removeClass('ui-state-hover');
                //  $("#gvPersonalMedical").resetSelection();
                var result = false;
                result = $(e.target).closest("tr").children('td').children('input')[0].checked;

                if ($(e.target).closest("tr").children('td').children('input')[0].checked == false) {
                    $(e.target).closest("tr").children('td').children('input')[0].checked == false;
                    $(e.target).closest("tr").children('td').children('input')[0].value == false;
                }
                else {
                    var Latrow = $("#gvPersonalMedical").getRowData('10');
                    if (rowid == "10" && result) {
                        $("#gvPersonalMedical").clearGridData();
                        var localData = gPerMeddata.slice(0);
                        localData[9]["CHECK"] = "True";
                        $("#gvPersonalMedical").setGridParam({ data: gPerMeddata }).trigger('reloadGrid', [{ current: true }]);
                        // $('#gvPersonalMedical tr:eq(9)').addClass('ui-state-hover');
                        //  $("#gvPersonalMedical").jqGrid('setSelection', '04', true);


                    }
                    else if (Latrow["CHECK"] === "True" && rowid != "10") {
                        $("#gvPersonalMedical").getRowData(rowid)["CHECK"] = "True";
                        var localData = $("#gvPersonalMedical").getRowData();
                        localData[9]["CHECK"] = "False";
                        $("#gvPersonalMedical").clearGridData();
                        $("#gvPersonalMedical").setGridParam({ data: localData }).trigger('reloadGrid', [{ current: true }]);
                        $('#gvPersonalMedical tr:eq(' + parseInt(rowid) + ')').addClass('ui-state-hover');

                        //  $("#gvPersonalMedical").jqGrid('setSelection', rowid);
                    }
                    else {
                        //$(e.target.closest('tr')).addClass('ui-state-hover');
                        //$("#gvPersonalMedical").jqGrid('setSelection', rowid);
                    }
                }

                return result;
                return true;

            },

            afterEditCell: function (id, name, val, iRow, iCol) {
                saverow = iRow;
                savecol = iCol;
            },

            loadComplete: function () {
                if ($('#gvPersonalMedical').jqGrid('getGridParam', 'reccount') == 0) {

                    $(".jqgfirstrow").css("height", "1px");
                }

            }
        }).trigger("reloadGrid");
        $('#gvPersonalMedical').jqGrid('setGroupHeaders', {
            useColSpanStyle: true,
            groupHeaders: [
              { startColumnName: 'DURATION', numberOfColumns: 2, titleText: 'Duration' },

            ]
        });
        jQuery("#gvPersonalMedical").jqGrid('bindKeys');
    }
    function CreateInvestigation() {
        var ColName = new Array();
        var ColModel = new Array();
        ColName.push("ServCode");
        ColModel.push({ name: "TESTCODE", index: "TESTCODE", key: true, hidden: true });
        //ColName.push("rm");
        //ColModel.push({ name: "RM", index: "RM", width: 50 });
        ColName.push("Test Name");
        ColModel.push({
            name: "TESTNAME", index: "TESTNAME", width: 450, editable: false, sortable: true
        });
        $('#GvService').jqGrid({
            datatype: 'local',
            //data: gTreatmentdata,
            colNames: ColName,
            colModel: ColModel,
            loadtext: "Loading...",
            cellEdit: true,
            cellsubmit: 'clientArray',
            shrinkToFit: false,
            rowNum: 999999999999,
            width: $('#gbox_GvService').parent().width(),
            height: 195,//218
            loadComplete: function () {
                if ($('#GvService').jqGrid('getGridParam', 'reccount') == 0) {

                    $(".jqgfirstrow").css("height", "1px");
                }

            }
        }).trigger("reloadGrid");

    }
    function CreateTreatmentGrid() {

        var ColName = new Array();
        var ColModel = new Array();
        var increment = 0;

        //for (var i = 0; i < 50; i++) {
        //    gTreatmentdata.push({ ID: i + 1 });
        //}
        ColName.push("id");
        ColModel.push({ name: "ID", index: "ID", key: true, hidden: true });
        ColName.push("Drug Form");
        ColModel.push({
            name: 'DRUGFORM',
            index: 'DRUGFORM',
            width: 70,
            sortable: false,
            editable: false,
            edittype: 'select',
            formatter: 'select',
            //editrules: { required: true },
            editoptions: {
                width: '100px',
                value: { select: ' ', S: 'SYP', T: 'TAB', I: 'INJ', C: 'CAP' },

            }
        }),

        ColName.push("Generic");
        ColModel.push({
            name: 'GENERICNAME',
            index: 'GENERICNAME',
            width: 280,
            sortable: false,
            editable: false,
            // editrules: { required: true },
            editoptions: {
                maxlength: 50
            }
        }),
        ColName.push("Drug Name");
        ColModel.push({
            name: 'DRUGNM',
            index: 'DRUGNM',
            width: 300,
            sortable: true,
            editable: false,
            //editrules: { required: true },
            editoptions: {
                maxlength: 50
            }
        }),
        ColName.push("Dose");
        ColModel.push({
            name: "DOSSAGE", index: "DOSSAGE", width: 100, editable: false, sortable: true, editoptions: {

            }
        });
        ColName.push("Route");
        ColModel.push({
            name: "ROUTE", index: "ROUTE", edittype: 'select', formatter: 'select', width: 70, editable: false, sortable: true,
            editoptions: {
                value: { select: ' ', O: 'ORAL', M: 'IM', V: 'IV', L: 'L/A' },
            }
        });
        ColName.push("No Of Days");
        ColModel.push({
            name: "DAYS", index: "DAYS", width: 90, editable: false, sortable: true, editoptions: {
                maxlength: 3, dataInit: function (element) {
                    $(element).keypress(function (e) {
                        if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
                            return false;
                        }
                    });
                }
            }
        });
        ColName.push("M");
        ColModel.push({
            name: "INT1", index: "INT1", width: 40, editable: false,
            align: 'center',
            edittype: 'checkbox',
            formatter: "checkbox", formatoptions: { disabled: false },
            editoptions: { value: "Y:N" }
        })
        ColName.push("A");
        ColModel.push({
            name: "INT2", index: "INT2", width: 40, editable: false,
            align: 'center',
            edittype: 'checkbox',
            formatter: "checkbox", formatoptions: { disabled: false },
            editoptions: { value: "Y:N" }
        })
        ColName.push("E");
        ColModel.push({
            name: "INT3", index: "INT3", width: 40, editable: false,
            align: 'center',
            edittype: 'checkbox',
            formatter: "checkbox", formatoptions: { disabled: false },
            editoptions: { value: "Y:N" }
        });
        ColName.push("N");
        ColModel.push({
            name: "INT4", index: "INT4", width: 40, editable: false,
            align: 'center',
            edittype: 'checkbox',
            formatter: "checkbox", formatoptions: { disabled: false },
            editoptions: { value: "Y:N" }
        })
        //ColName.push("5");
        //ColModel.push({
        //    name: "INT5", index: "INT5", width: 40, editable: false,
        //    align: 'center',
        //    edittype: 'checkbox',
        //    formatter: "checkbox", formatoptions: { disabled: false },
        //    editoptions: { value: "Y:N" }
        //});
        ColName.push("Remarks");
        ColModel.push({ name: "Remarks", index: "Remarks", width: 160, editable: false, sortable: true });
        $('#gvTreatment').jqGrid({
            datatype: 'local',
            //data: gTreatmentdata,
            colNames: ColName,
            colModel: ColModel,
            loadtext: "Loading...",
            cellEdit: false,
            cellsubmit: 'clientArray',
            shrinkToFit: false,
            rowNum: 999999999999,
            width: $('#gbox_gvTreatment').parent().width(),
            height: 195,//218
            //beforeSelectRow: function (rowid, e) {
            //    if (!$('#btnSave').is(":visible")) {
            //        return false;
            //    }
            //    return true;
            //},
            //afterEditCell: function (id, name, val, iRow, iCol) {

            //    $("#" + iRow + "_" + name).bind('blur', function (e) {
            //        $('#gvTreatment').saveCell(iRow, iCol);

            //    });
            //},


            loadComplete: function () {
                if ($('#gvTreatment').jqGrid('getGridParam', 'reccount') == 0) {

                    $(".jqgfirstrow").css("height", "1px");
                }

            }
        }).trigger("reloadGrid");
        $('#gvTreatment').jqGrid('setGroupHeaders', {
            useColSpanStyle: true,
            groupHeaders: [
              { startColumnName: 'INT1', numberOfColumns: 4, titleText: 'In Take' }
            ]
        });
    }


    function CreateAdviceGrid() {

        var ColName = new Array();
        var ColModel = new Array();
        var increment = 0;

        for (var i = 0; i < 50; i++) {
            gAdvicedata.push({ ID: i, RM: '<span class="ui-icon ui-icon-cancel">Remove</span>' });
        }

        ColName.push("RM");
        ColModel.push({ name: "RM", index: "RM", width: 30 });
        ColName.push("id");
        ColModel.push({ name: "ID", index: "ID", key: true, hidden: true });
        ColName.push("DRUGCD");
        ColModel.push({ name: "DRUGCD", index: "DRUGCD", key: true, hidden: true });
        ColName.push("GENERICID");
        ColModel.push({ name: "GENERICID", index: "GENERICID", key: true, hidden: true });
        ColName.push("Drug Form");
        ColModel.push({
            name: 'DRUGFORM',
            index: 'DRUGFORM',
            width: 70,
            sortable: false,
            editable: true,
            edittype: 'select',
            formatter: 'select',
            //editrules: { required: true },
            editoptions: {
                width: '100px',
                value: { select: ' ', S: 'SYP', T: 'TAB', I: 'INJ', C: 'CAP' },

            }
        }),

        ColName.push("Generic");
        ColModel.push({
            name: 'GENERICNAME',
            index: 'GENERICNAME',
            width: 280,
            sortable: false,
            editable: true,
            // editrules: { required: true },
            editoptions: {
                maxlength: 50
            }
        }),
        ColName.push("Drug Name");
        ColModel.push({
            name: 'DRUGNM',
            index: 'DRUGNM',
            width: 300,
            sortable: true,
            editable: true,
            //editrules: { required: true },
            editoptions: {
                maxlength: 50
            }
        }),
        ColName.push("Dose");
        ColModel.push({
            name: "DOSSAGE", index: "DOSSAGE", width: 100, editable: true, sortable: true, editoptions: {

            }
        });
        ColName.push("Route");
        ColModel.push({
            name: "ROUTE", index: "ROUTE", edittype: 'select', formatter: 'select', width: 70, editable: true, sortable: true,
            editoptions: {
                value: { select: ' ', O: 'ORAL', M: 'IM', V: 'IV', L: 'L/A' },
            }
        });
        ColName.push("No Of Days");
        ColModel.push({
            name: "DAYS", index: "DAYS", width: 65, editable: true, sortable: true, editoptions: {
                maxlength: 3, dataInit: function (element) {
                    $(element).keypress(function (e) {
                        if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
                            return false;
                        }
                    });
                }
            }
        });
        ColName.push("M");
        ColModel.push({
            name: "INT1", index: "INT1", width: 40, editable: false,
            align: 'center',
            edittype: 'checkbox',
            formatter: "checkbox", formatoptions: { disabled: false },
            editoptions: { value: "Y:N" }
        })
        ColName.push("A");
        ColModel.push({
            name: "INT2", index: "INT2", width: 40, editable: false,
            align: 'center',
            edittype: 'checkbox',
            formatter: "checkbox", formatoptions: { disabled: false },
            editoptions: { value: "Y:N" }
        })
        ColName.push("E");
        ColModel.push({
            name: "INT3", index: "INT3", width: 40, editable: false,
            align: 'center',
            edittype: 'checkbox',
            formatter: "checkbox", formatoptions: { disabled: false },
            editoptions: { value: "Y:N" }
        });
        ColName.push("N");
        ColModel.push({
            name: "INT4", index: "INT4", width: 40, editable: false,
            align: 'center',
            edittype: 'checkbox',
            formatter: "checkbox", formatoptions: { disabled: false },
            editoptions: { value: "Y:N" }
        })
        //ColName.push("5");
        //ColModel.push({
        //    name: "INT5", index: "INT5", width: 40, editable: false,
        //    align: 'center',
        //    edittype: 'checkbox',
        //    formatter: "checkbox", formatoptions: { disabled: false },
        //    editoptions: { value: "Y:N" }
        //});

        ColName.push("Remarks");
        ColModel.push({ name: "Remarks", index: "Remarks", width: 160, editable: true, sortable: true });
        $('#gvAdvice').jqGrid({
            datatype: 'local',
            data: gAdvicedata,
            colNames: ColName,
            colModel: ColModel,
            loadtext: "Loading...",
            cellEdit: true,
            cellsubmit: 'clientArray',
            shrinkToFit: false,
            rowNum: 999999999999,
            width: $('#gbox_gvAdvice').parent().width(),  //--unnati-- previous 1265
            height: 195,
            beforeSelectRow: function (rowid, e) {
                if (!$('#btnSave').is(":visible")) {
                    return false;
                }
                return true;
            },
            afterEditCell: function (id, name, val, iRow, iCol) {

                $("#" + iRow + "_" + name).bind('blur', function (e) {
                    $('#gvTreatment').saveCell(iRow, iCol);

                });
            },


            loadComplete: function () {
                if ($('#gvAdvice').jqGrid('getGridParam', 'reccount') == 0) {

                    $(".jqgfirstrow").css("height", "1px");
                }

                if ($("#spTRANMODE")[0].textContent == "2") {
                    var advisedata = $("#gvAdvice").jqGrid('getGridParam', 'data');
                    var a = advisedata.length;

                    if (rowadded == false) {
                        var myfirstrow = { DRUGCD: "", GENERICID: "", DRUGFORM: "", GENERICNAME: "", DRUGNM: "", DOSSAGE: "", DAYS: "", INT1: "", INT2: "", INT3: "", INT4: "", ROUTE: "", Remarks: "" };
                        $("#gvAdvice").jqGrid("addRowData", Number(a) + 1, myfirstrow);
                        rowadded = true;
                    }
                    else {
                        if (a != 0) {
                            if (advisedata[advisedata.length - 1].DRUGNM != "" && a != 50) {
                                for (var i = 0; i < 20; i++) {
                                    var myfirstrow = { RM: '<span class="ui-icon ui-icon-cancel">Remove</span>', DRUGCD: "", GENERICID: "", DRUGFORM: "", GENERICNAME: "", DRUGNM: "", DOSSAGE: "", DAYS: "", INT1: "", INT2: "", INT3: "", INT4: "", ROUTE: "", Remarks: "" };
                                    $("#gvAdvice").jqGrid("addRowData", Number(a) + 1, myfirstrow);
                                    a++;
                                }
                            }
                        }
                        else {
                            for (var i = 0; i < 20; i++) {
                                var myfirstrow = { RM: '<span class="ui-icon ui-icon-cancel">Remove</span>', DRUGCD: "", GENERICID: "", DRUGFORM: "", GENERICNAME: "", DRUGNM: "", DOSSAGE: "", DAYS: "", INT1: "", INT2: "", INT3: "", INT4: "", ROUTE: "", Remarks: "" };
                                $("#gvAdvice").jqGrid("addRowData", Number(a) + 1, myfirstrow);
                                a++;
                            }
                        }
                    }



                }

            },//remove row on click remove btn -- on DRUGNM 
            onCellSelect: function (rowId, iCol, content, event) {
                rows = $('#gvAdvice')[0].rows;
                var rowdat = $('#gvAdvice').getRowData(rowId);
                if (iCol == 0 && rowId != rows.length - 1 && rows.length - 1 > 1) {
                    if ($('#gvAdvice').jqGrid('getCell', rowId, 'DRUGNM') != "") {
                        $('#gvAdvice').jqGrid("editCell", 1, 2, false);
                        $('#gvAdvice').jqGrid('delRowData', rowId);
                    }
                    else {

                    }


                }
                else {
                    //var index = $('#tblRequiInfo').jqGrid('getInd', rowId);
                    //$('#gvAdvice')[0].rows[index].cells[2].className = 'editable-cell';
                    //$('#gvAdvice')[0].rows[index].cells[3].className = 'editable-cell';
                    //$('#gvAdvice')[0].rows[index].cells[4].className = 'editable-cell';
                }
            },
        }).trigger("reloadGrid");
        $('#gvAdvice').jqGrid('setGroupHeaders', {
            useColSpanStyle: true,
            groupHeaders: [
              { startColumnName: 'INT1', numberOfColumns: 4, titleText: 'In Take' }
            ]
        });
    }


    function getDBDate(strDate) {
        return strDate.substr(6, 2) + "/" + strDate.substr(4, 2) + "/" + strDate.substr(0, 4)
    }

    function BindPatTranData(PatTranData, patCatgnm) {
        $('#txtICDNM').attr('disabled', true);
        $('#txtICDCD').attr('disabled', true);

        $('.CurrentTabContent input:checked').prop('checked', false);
        var prevWeight = $('#txtPrevWeight').val();
        $('.CurrentTabContent input[type=text]').val('');
        $('.CurrentTabContent textarea').val('');
        $('#txtPrevWeight').val(prevWeight);
        hideAllDiv();
        var PatData = JSON.parse(PatTranData)[0];
        if (PatData.PCOTHER.trim() !== "") {
            $('#chkPCOthers').prop('checked', true);
            $('#txtPCOthers').val(PatData.PCOTHER);
            $('#txtPCOthers').show();
        }
        $('#txtDiagnosis').val(PatData.DIAGNOSIS);
        $('#txtSHist').val(PatData.SURGHIST);

        $('#txtICDCD').val(PatData.ICDCODE);
        $('#txtICDNM').val(PatData.INAME);

        $('#spTranDt').text(PatData.TRANDATE);
        $('#spTranTM').text(PatData.TRANTIME);

        $('#txtPHist').val(PatData.PASTHIST);
        $('#txtEExam').val(PatData.EXAM);
        $('#txtWeight').val(PatData.WEIGHT);
        $('#txtHeight').val(PatData.HEIGHT);
        $('#txtTemp').val(PatData.TEMP);
        $('#txtPulse').val(PatData.PULSE);
        $('#txtResp').val(PatData.RESP);
        $('#txtBP').val(PatData.BP);
        $('#txtVitalOthers').val(PatData.VOTHERS);
        if (PatData.PPOTHER.trim() !== "") {
            $('#chkPerOthers').prop('checked', true);
            $('#txtPerOthers').val(PatData.PPOTHER);
            $('#txtPerOthers').show();
        }
        if (PatData.PMOTHER.trim() !== "") {
            $('#chkPerMedOthers').prop('checked', true);
            $('#txtPerMedOthers').val(PatData.PMOTHER);
            $('#txtPerMedOthers').show();
        }
        if (("" + PatData.INVESTOTHER).trim() !== "") {
            $('#chkInvest').prop('checked', true);
            $('#txtInvest').val(PatData.INVESTOTHER);
            $('#txtInvest').show();
        }

        if (("" + PatData.TOTHERS).trim() !== "") {
            $('#txtAdAlterMedDetails').val(PatData.TOTHERS);
            $('#txtAdAlterMedDetails').show();
            // $('#txtAdAlterMedDetails').val(PatData.TOTHERS);
            // $('#txtAdAlterMedDetails').show(); 
        }


        if (PatData.ALTMEDIYN.trim() !== "")
            $("#divAlterMed input[value=" + PatData.ALTMEDIYN + "]").trigger('click');

        $('#txtAlterMedDetails').val(PatData.TOTHERS);

        //$('#txtEOthers').val(PatData.ONEXAMDET.trim())

        //if (("" + PatData.ADVICE).trim() !== "") {
        //    $("#divAdvice input[value=" + PatData.ADVICE.trim() + "]").trigger('click');
        //}

        //$('#divDoctName').hide();
        //$('#divPatCatg').hide();
        //$('#divOldPatCatg').show();
        //$('#divOldDoctName').show();
        //$('#divOldDoctName span').remove();
        //$('#divOldPatCatg span').remove();
        //$('#divOldPatCatg label').remove();
        //$('#divOldPatCatg').append('<span id="spOldPatG" style="display:none">' + PatData.PATCATG + '</span>');
        //if (PatData.COMPNAME.trim() === "") {

        //    $('#divOldPatCatg').append('<span id="spOldPatDesc">' + patCatgnm + '</span>');
        //}
        //else {

        //    $('#divOldPatCatg').append('<label> Company Name : </label>');
        //    $('#divOldPatCatg').append('<span id="spOldCompName">' + PatData.COMPNAME + '</span>');
        //}
        //$('#divOldDoctName').append('<span id="spOldDoct">' + PatData.DOCTORNAME + '</span>');

    }
    function BindComplaintGrid(PresComplaint) {
        var rowData = "";
        // var data = gPreCompdata;
        for (var i = 0; i < PresComplaint.length; i++) {
            if (PresComplaint[i].GRPCD.trim() != "") {
                $('#gvComplaints').expandSubGridRow(PresComplaint[i].GRPCD.trim());
                rowData = $('#gvComplaints' + '_' + PresComplaint[i].GRPCD.trim() + '_per').jqGrid('getRowData', PresComplaint[i].DESCCD);
            }
            else rowData = $('#gvComplaints').jqGrid('getRowData', PresComplaint[i].DESCCD);
            rowData.CHECK = 'True';
            rowData.DURATION = PresComplaint[i].DURATION;
            rowData.DURTYPE = PresComplaint[i].DURTYPE;
            rowData.REMARKS = PresComplaint[i].REMARKS;
            // var index = i+1;
            var rowId = PresComplaint[i].DESCCD; //jQuery('#gvComplaints tr:eq(' + index + ')').attr('id');
            var dataFromTheRow = jQuery('#gvComplaints').jqGrid('getRowData', rowId);
            if (PresComplaint[i].GRPCD.trim() != "") {
                $('#gvComplaints' + '_' + PresComplaint[i].GRPCD.trim() + '_per').jqGrid('setRowData', rowId, rowData);
            }
            else
                $('#gvComplaints').jqGrid('setRowData', rowId, rowData);
        }


        //here filter gvcomplaints first set checked row and then set empty row
        var myarray = [];
        var gvarray = $("#gvComplaints").jqGrid('getRowData');
        grep1 = $.grep(gvarray, function (e) { return e.CHECK == 'True'; });
        var grep2 = $.grep(gvarray, function (e) { return e.CHECK != 'True'; });

        $('#gvComplaints').clearGridData();
        ////myarray.push(grep1, grep2);
        for (var i = 0; i <= grep1.length - 1; i++) {
            myarray.push(grep1[i]);
            // var rowid = grep1[i].DESCCD;
            //jQuery('#gvComplaints').setRowData(rowid, '', { 'background-color': '#b2ffb2' });//selected row set bgcolor #FF6F6F
        }
        for (var i = 0; i <= grep2.length - 1; i++) {
            myarray.push(grep2[i]);
        }
        $('#gvComplaints').setGridParam({ data: myarray }).trigger('reloadGrid');
    }
    function BindPerAddictGrid(AddictData) {
        // var data = gPreCompdata;
        for (var i = 0; i < AddictData.length; i++) {
            var rowData = $('#gvPersonal').jqGrid('getRowData', AddictData[i].ADDICTCD);
            rowData.CHECK = 'True';
            rowData.STARTAGE = AddictData[i].STARTAGE;
            rowData.STOPAGE = AddictData[i].STOPAGE;
            $('#gvPersonal').jqGrid('setRowData', AddictData[i].ADDICTCD, rowData);
        }
    }
    function BindPerMedGrid(PerMedData) {
        // var data = gPreCompdata;
        for (var i = 0; i < PerMedData.length; i++) {
            var rowData = $('#gvPersonalMedical').jqGrid('getRowData', PerMedData[i].MEDCD);
            rowData.CHECK = 'True';
            rowData.DURATION = PerMedData[i].DURATION;
            rowData.DURTYPE = PerMedData[i].DURTYPE;
            rowData.ONREGTREATYN = PerMedData[i].ONREGTREATYN;
            $('#gvPersonalMedical').jqGrid('setRowData', PerMedData[i].MEDCD, rowData);
        }
    }

    //BIND TREATMENT ADVICE 
    function BindTreatGrid(TreatmentData) {

        //bind treatment advice grid here
        $('#gvAdvice').clearGridData();
        $('#gvAdvice').setGridParam({ data: TreatmentData }).trigger('reloadGrid');

        var rowIDs = $("#gvAdvice").jqGrid('getDataIDs');
        for (var i = 0; i < rowIDs.length; i++) {
            var rowId = rowIDs[i];
            var rowdata = jQuery('#gvAdvice').jqGrid('getRowData', rowId);
            $("#gvAdvice").jqGrid("setCell", rowIDs[i], "RM", '<span class="ui-icon ui-icon-cancel">Remove</span>');
        }
    }
    //bind treatment received grid here
    function BindTreatmentRecGrid(TreatmentRecData) {
        $('#gvTreatment').clearGridData();
        $('#gvTreatment').setGridParam({ data: TreatmentRecData }).trigger('reloadGrid');
    }

    function BindFamilyGrid(FamilyData) {
        $('#gvFamily').clearGridData();
        $('#gvFamily').setGridParam({ data: FamilyData }).trigger('reloadGrid');
    }
    function BindInvestGrid(InvestData) {
        $('#GvService').clearGridData();
        $('#GvService').setGridParam({ data: InvestData }).trigger('reloadGrid');
    }
    function BindNotesGrid(NotesData) {
        for (i = 0 ; i < NotesData.length; i++)
            $('#ulNewNotes').append('<li>' + NotesData[i].NOTE + '</li>');
        //$('#GvService').clearGridData();
        //$('#GvService').setGridParam({ data: InvestData }).trigger('reloadGrid');
    }


    //print function

    function PrintData(TranNo, TranDt, TranTime, DispPrint) {

        if (TranNo == "p") {
            TranNo = '<%:Model.TRANNO%>';
        }
        else if (TranDt == "d") {
            TranDt = '<%:Model.TRANDT%>';
        }
        else if (TranTime == "a") {
            TranTime = '<%:Model.TRANTM%>';
        }

    var strPrindData = [];
    strPrindData.push("<html><body>");
    strPrindData.push(" <style>.cltable {border-collapse: collapse;} table.cltable td, th {border: 1px solid #ddd;"
   + "text-align: left;}</style>"
        );
    var label = "Patient Category";
    var Patcatg = $('#spPatcatgnm')[0].textContent;

    var doctName = "";


        //patient and doctor info
    doctName = $('#spDoctName').text();
    strPrindData.push("<div style='text-align: center;'><label style='font-weight:bold;font-size: 23px;'> </label></div><hr color=black>" +
        "<table style='width:100%;font-family:Times New Roman'>"
            + " <tr><td style=color:blue>Name</td><td style='width:1%'>:</td><td style=font-weight:bold;width:40%>" + $('#spPatName').text() + "</td>" +
             "<td style=color:blue;width=5% >Tran No</td><td style='width:1%'>:</td><td width=35%>" + TranNo
               + "</td></tr> "
                + " <tr><td style=color:blue >Age / Gender</td><td >:</td>"
             + "<td>" + $('#spAge').text() + " / " + $('#spGender').text() + "</td>" +
            "<td style=color:blue;>Tran Date / Time</td><td>:</td><td>" + TranDt + "  " + TranTime
               + "</td></tr> "
               + " <tr><td style=color:blue>Mobile No.</td><td >:</td>"
             + "<td>" + $('#spMobile').text() + "</td>" +
             "<td style=color:blue>MR No.</td><td>:</td><td>" + $('#spMRNO').text()
               + "</tr> "

                + " <tr><td style=color:blue>Doctor Name</td><td>:</td><td>" + doctName + "</td>" +
             "<td style=color:blue;>Patient Category</td><td >:</td><td>" + Patcatg + "</td></tr> "
              + "</table><hr color=black>");

    var strVOther = "";
    if ($('#txtVitalOthers').val().trim() !== "") {
        strVOther = "" + $('#txtVitalOthers').val().trim()
    }

        //Vitals
    strPrindData.push("<table style='width:100%;font-family:Times New Roman;border-color:black'><tr><td width=30% style='vertical-align:top;'><div><table>")

    if ($('#txtWeight').val() != 0) {
        strPrindData.push("<tr><td>")

        strPrindData.push("<label style=color:blue;font-weight:bold;vertical-align=top><u>Vitals </u>: </label></br> ");
        strPrindData.push("<table>");
        if ($('#txtWeight').val().trim() !== "") {
            strPrindData.push("<tr><td style=font-weight:bold> Weight : </td><td>" + $('#txtWeight').val() + " Kg </td></tr>");
        }
        if ($('#txtHeight').val().trim() !== "") {
            strPrindData.push("<tr><td style=font-weight:bold> Height :</td><td> " + $('#txtHeight').val() + "ft</td></tr>");
        }
        if ($('#txtTemp').val().trim() !== "") {
            strPrindData.push("<tr><td style=font-weight:bold>  Temp : </td><td>" + $('#txtTemp').val() + " </td></tr>");
        }
        if ($('#txtPulse').val().trim() !== "") {
            strPrindData.push("<tr><td style=font-weight:bold> Pulse : </td><td>" + $('#txtPulse').val() + "</td></tr>");
        }
        if ($('#txtResp').val().trim() !== "") {
            strPrindData.push("<tr><td style=font-weight:bold> Resp : </td><td>" + $('#txtResp').val() + "</td></tr>");
        }
        if ($('#txtBP').val().trim() !== "") {
            strPrindData.push("<tr><td style=font-weight:bold> Bp : </td><td>" + $('#txtBP').val() + "</td></tr>");
        }
        if ($('#txtVitalOthers').val().trim() !== "") {
            strPrindData.push("<tr><td colspan=2>" + strVOther + "</td></tr>");
        }
        strPrindData.push("</table>");

        strPrindData.push("</br>");
        strPrindData.push("</td></tr>");
    }

        //Personal History 
    var PersonalData = $.grep($('#gvPersonal').getRowData(), function (e) { return e.CHECK == "True"; });
    var MedicalData = $.grep($('#gvPersonalMedical').getRowData(), function (e) { return e.CHECK == "True"; });
    if (PersonalData.length > 0 || PersonalData.length > 0) {
        strPrindData.push("<tr><td>")

        strPrindData.push("<table>");
        strPrindData.push("<tr style=font-weight:bold><td>Addiction&nbsp;&nbsp;&nbsp;</td><td>Start Age&nbsp;&nbsp;&nbsp;</td><td>Stop Age &nbsp;&nbsp;&nbsp;</td></tr>");
        for (var i = 0; i < PersonalData.length; i++) {
            if (i == 0) {
                strPrindData.push("<p><label style=color:blue;font-weight:bold><u>Personal History </u>: </label></br>");
            }

            // strPrindData.push("<tr><td>" + PersonalData[i].DESC + "</td><td> " + PersonalData[i].STARTAGE + "(yrs)</td><td>" + PersonalData[i].STOPAGE + "(yrs)</td></tr>");
            strPrindData.push("<tr>");
            if (PersonalData[i].DESC !== "") {
                strPrindData.push("<td>" + PersonalData[i].DESC + "</td>");
            }
            if (PersonalData[i].STARTAGE !== "") {
                strPrindData.push("<td> " + PersonalData[i].STARTAGE + " (yrs)</td>");
            }
            if (PersonalData[i].STOPAGE !== "") {
                strPrindData.push("<td>" + PersonalData[i].STOPAGE + " (yrs)</td");
            }
            strPrindData.push("</tr>");

        }
        strPrindData.push("</table>")
        if ($('#txtPerOthers').val().trim() !== "") {
            if ($('#chkPerOthers').prop('checked')) {
                strPrindData.push("" + $('#txtPerOthers').val() + "</p>");
            }
        }

        //medical History
        strPrindData.push("<table>");
        strPrindData.push("<tr style=font-weight:bold><td>Suffering&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td>Duration&nbsp;&nbsp;&nbsp;</td><td>Remarks &nbsp;&nbsp;&nbsp;</td></tr>");
        for (var i = 0; i < MedicalData.length; i++) {
            if (i == 0) {
                strPrindData.push("</br></br><label style=color:blue;font-weight:bold><u>Medical History </u>: </label></br>");
            }

            strPrindData.push("<tr>");
            if (MedicalData[i].DESC !== "") {
                strPrindData.push("<td>" + MedicalData[i].DESC + "</td>");
            }
            if (MedicalData[i].DURATIONE !== "") {
                strPrindData.push("<td> " + MedicalData[i].DURATION + " " + gDurType[MedicalData[i].DURTYPE] + "</td>");
            }
            if (MedicalData[i].ONREGTREATYN !== "") {
                strPrindData.push("<td>" + MedicalData[i].ONREGTREATYN + "</td");
            }
            strPrindData.push("</tr>");
        }
        strPrindData.push("</table>")
        if ($('#txtPerMedOthers').val().trim() !== "") {
            if ($('#chkPerMedOthers').prop('checked')) {
                strPrindData.push("" + $('#txtPerMedOthers').val() + "</br>");
            }
        }
        strPrindData.push("</br>");
        strPrindData.push("</td></tr>");
    }




        //Past Hist
    var PastHist = "";

    PastHist = $('#txtPHist').val().trim();

    if (PastHist.trim() !== "") {
        strPrindData.push("<tr><td></br></br><label style=color:blue;font-weight:bold><u>Past History </u>: </label>");
        strPrindData.push("</br>" + PastHist + "</br></td></tr>");
    }

        //Surgical History
    var SurgHist = "";
    SurgHist = $('#txtSHist').val().trim();

    if (SurgHist.trim() !== "") {
        strPrindData.push("<tr><td>");
        strPrindData.push("</br><label style=color:blue;font-weight:bold><u>Surgical History</u> : </label>");
        strPrindData.push("</br>" + SurgHist + "</br>");
        strPrindData.push("</td></tr>");
    }
    strPrindData.push("</td></tr></table></div></td>");

        //second td
    if (SurgHist.trim() !== "" || PastHist.trim() !== "" || $('#txtPerMedOthers').val().trim() !== "" || PersonalData.length > 0 || MedicalData.length > 0 || $('#txtWeight').val() != 0) {
        strPrindData.push("<td width=2% style='border-left:thin solid';></td>");
    }


        //Present Complaint(s)  third td
    strPrindData.push("</br><td style='vertical-align:top;'>");
    strPrindData.push("<div>");
    strPrindData.push("<table style='font-family:Times New Roman'>");


    var ComplaintData = $.grep($('#gvComplaints').getRowData(), function (e) { return e.CHECK == "True"; });
    for (var i = 0; i < ComplaintData.length; i++) {
        if (i == 0) {
            strPrindData.push("<tr><td><label style=color:blue;font-weight:bold><u>Present Complaint(s) </u>: </label>");
            strPrindData.push("<table>");
            strPrindData.push("<tr style=font-weight:bold><td>Description&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td>Duration&nbsp;&nbsp;&nbsp;</td><td>Remarks &nbsp;&nbsp;&nbsp;</td></tr>");
        }

        strPrindData.push("<tr>");
        if (ComplaintData[i].DESC !== "") {
            strPrindData.push("<td>" + ComplaintData[i].DESC + "</td>");
        }
        if (ComplaintData[i].DURATION !== "") {
            strPrindData.push("<td> " + ComplaintData[i].DURATION + " " + gDurType[ComplaintData[i].DURTYPE] + "</td>");
        }
        if (ComplaintData[i].REMARKS !== "") {
            strPrindData.push("<td>" + ComplaintData[i].REMARKS + "</td");
        }
        strPrindData.push("</tr>");

        if (i == ComplaintData.length - 1) {
            strPrindData.push("</table>")
            strPrindData.push("</td></tr>");
        }

    }

    if ($('#chkPCOthers').prop('checked')) {
        strPrindData.push("<tr><td>" + $('#txtPCOthers').val().trim());
        strPrindData.push("</td></tr>");
    }
        //ICD 
    var ICD = "";

    ICD = $('#txtICDCD').val().trim() + "    " + $('#txtICDNM').val().trim();

    if (ICD.trim() !== "") {
        strPrindData.push("<tr><td>");

        strPrindData.push("<label style=color:blue;font-weight:bold><u>ICD </u>: </label>");
        strPrindData.push("</br>" + ICD + "");
        strPrindData.push("</td></tr>");
    }

        //DiagNos
    var DiagNos = "";

    DiagNos = $('#txtDiagnosis').val().trim();

    if (DiagNos.trim() !== "") {
        strPrindData.push("<tr><td>");
        strPrindData.push("</br></br><label style=color:blue;font-weight:bold><u>Diagnosis </u>: </label>");
        strPrindData.push("</br>" + DiagNos);
        strPrindData.push("</td></tr>");
    }

        //Examinations
    var OnExam = "";

    OnExam = $('#txtEExam').val().trim();

    if (OnExam.trim() !== "") {
        strPrindData.push("<tr><td>");
        strPrindData.push("</br></br><label style=color:blue;font-weight:bold><u>On Examinations </u>: </label>");
        strPrindData.push("</br>" + OnExam);
        strPrindData.push("</td></tr>");
    }

        //Investigations
    var Tests = $('#GvService').getRowData();
    if (Tests.length > 0) {
        strPrindData.push("<tr><td>");
        strPrindData.push("</br></br><label style=color:blue;font-weight:bold><u>Investigations </u>: </label>");
        for (var i = 0; i < Tests.length; i++) {
            strPrindData.push("<li>" + Tests[i].TESTNAME + "</li>");
        }
        strPrindData.push("</td></tr>");
    }

    var OtherInvest = "";

    OtherInvest = $('#txtInvest').val().trim();

    if (OtherInvest.trim() !== "") {
        strPrindData.push("<tr><td>");
        strPrindData.push("" + OtherInvest);
        strPrindData.push("</td></tr>");
    }

    strPrindData.push("</table></div>");
    strPrindData.push("</td></tr></table>");//main table end here



        //Family History
    var Family = $.grep($('#gvFamily').getRowData(), function (e) { return e.NAME.trim() !== ""; });
    for (var i = 0; i < Family.length; i++) {
        if (i == 0) {
            // strPrindData.push("<tr><td>");
            strPrindData.push("</br><label style=color:blue;font-weight:bold><u>Family History</u> : </label>");
            strPrindData.push("<table width=100%>");
            strPrindData.push("<tr style=font-weight:bold><td>Nmae&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td>Age&nbsp;</td><td>Relation &nbsp;&nbsp;&nbsp;</td><td>Diseases &nbsp;&nbsp;&nbsp;</td><td>Duration &nbsp;</td><td>Remarks &nbsp;&nbsp;&nbsp;</td></tr>");
        }

        strPrindData.push("<tr>");
        if (Family[i].NAME !== "") {
            strPrindData.push("<td>" + Family[i].NAME + "</td>");
        }
        if (Family[i].AGE !== "") {
            strPrindData.push("<td>" + Family[i].AGE + "</td>");
        }
        if (Family[i].RELATION !== "") {
            strPrindData.push("<td>" + gRelation[Family[i].RELATION] + "</td>");
        }
        if (Family[i].DISEASES !== "") {
            strPrindData.push("<td>" + Family[i].DISEASES + "</td>");
        }
        if (Family[i].DURATION !== "") {
            strPrindData.push("<td> " + Family[i].DURATION + " " + gDurType[Family[i].DURTYPE] + "(s)</td>");
        }
        if (Family[i].REMARKS !== "") {
            strPrindData.push("<td>" + Family[i].REMARKS + "</td");
        }
        strPrindData.push("</tr>");

        if (i == Family.length - 1) {
            strPrindData.push("</table>");
            if ($('#chkPerMedOthers').prop('checked')) {
                strPrindData.push("" + $('#txtPerMedOthers').val() + "</br>");
            }
        }
    }
        //end



        //Treatment Advice

    var Advice = $.grep($('#gvAdvice').getRowData(), function (e) { return e.DRUGNM.trim() !== ""; });

    if (Advice.length > 0) {
        strPrindData.push("<table width=100%><tr><td colspan=8>");
        strPrindData.push("</br><label style=color:blue;font-weight:bold;><u>Treatment Advice </u>: </label></td></tr>"); width = 5 %
        strPrindData.push("<tr><td><label style=color:black;font-weight:bold;>Form &nbsp;</label>");
        strPrindData.push("</td><td><label style=color:black;font-weight:bold;>Generic* &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>");
        strPrindData.push("</td><td><label style=color:black;font-weight:bold;>Drug Name** &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>");
        strPrindData.push("</td><td><label style=color:black;font-weight:bold;>Dose &nbsp;&nbsp;&nbsp;&nbsp;</label>");
        strPrindData.push("</td><td><label style=color:black;font-weight:bold;>Route &nbsp;</label>");
        strPrindData.push("</td><td><label style=color:black;font-weight:bold;>Days&nbsp</label></td>");
        strPrindData.push("<td><label style=color:black;font-weight:bold;>Intake &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label></td>");
        strPrindData.push("<td width=15%><label style=color:black;font-weight:bold;>Remark &nbsp;&nbsp;</label></td></tr>");
        strPrindData.push("<tr><td colspan=8><hr color=black></td></tr>");
        for (var i = 0; i < Advice.length; i++) {

            var strTake1 = (Advice[i].INT1 == "N") ? "0 " : "1 ";
            var strTake2 = (Advice[i].INT2 == "N") ? "- 0 " : "- 1 ";
            var strTake3 = (Advice[i].INT3 == "N") ? "- 0 " : "- 1 ";
            var strTake4 = (Advice[i].INT4 == "N") ? "- 0 " : "- 1 ";

            var Durgfrm = "";
            var Route = "";
            if (Advice[i].DRUGFORM == "S") { Durgfrm = "SYP" }
            else if (Advice[i].DRUGFORM == "T") { Durgfrm = "TAB" }
            else if (Advice[i].DRUGFORM == "I") { Durgfrm = "INJ" }
            else if (Advice[i].DRUGFORM == "C") { Durgfrm = "CAP" }

            if (Advice[i].ROUTE == "O") { Route = "ORAL" }
            else if (Advice[i].ROUTE == "M") { Route = "IM" }
            else if (Advice[i].ROUTE == "V") { Route = "IV" }
            else if (Advice[i].ROUTE == "L") { Route = "L/A" }
            //var strTake5 = (Advice[i].INT5 == "N") ? " 0" : " 1";   //<td>" + Advice[i].DRUGFORM + "</td><td>" + Advice[i].GENERICNAME + "</td>
            strPrindData.push("<tr><td>" + Durgfrm + "</td><td>" + Advice[i].GENERICNAME + "</td><td>" + Advice[i].DRUGNM + "</td><td>" + Advice[i].DOSSAGE + "</td><td>" + Route + "</td><td>" + "&nbsp;&nbsp;&nbsp;&nbsp;" + Advice[i].DAYS
                + "</td><td>" + strTake1 + strTake2 + strTake3 + strTake4 + "</td><td>" + Advice[i].Remarks +//<td>" + Advice[i].ROUTE + "</td>
                   "</td></tr>");//strTake5 +
        }
        strPrindData.push("</table>");
    }


        // strPrindData.push("</td></tr>");
        //strPrindData.push("</table>");


        //Advice
    if ($('#divAdvice input:checked').val() !== undefined) {
        strPrindData.push("<label style=font-weight:bold;>Advice</label><hr color=black>");
        if ($('#chkAdvRFtherapy').prop('checked')) {
            strPrindData.push("<p>Radiation therapy followed by brachytherapy</p>");
        }
        if ($('#chkAdvRWtherapy').prop('checked')) {
            strPrindData.push("<p>Radiation therapy with concurrent chemotherapy followed by brachytherapy</p>");
        }
        if ($('#chkAdvEFtherapy').prop('checked')) {
            strPrindData.push("<p> Extended field radiation therapy followed by brachytherapy</p>");
        }
        if ($('#chkAdvEWtherapy').prop('checked')) {
            strPrindData.push("<p>Extended field radiation therapy with concurrent chemotherapy followed by brachytherapy</p>");
        }

        var a = "";

        var b = a.split(' ');
        b.length > 0

        b[0]
    }

    if (Advice.length > 0 || OtherInvest.trim() !== "" || OnExam.trim() !== "" || DiagNos.trim() !== "" || ICD.trim() !== "" || SurgHist.trim() !== "" || PastHist.trim() !== "" || ComplaintData.length > 0 || Family.length > 0 || PersonalData.length > 0 || $('#txtWeight').val() != 0) {
        strPrindData.push("</br><hr color=black>");
    }
        //NOTE
    if (Advice.length > 0) {
        strPrindData.push("</br><label style=color:black;font-weight:bold;>NOTE : </label>"); width = 5 %
        strPrindData.push("</br><label style=color:red;font-weight:normal;>* Pharmacist is supposed to supply by 'GENERIC' only. The physician is not responsible for the quality efficacy or side effects</label>");
        strPrindData.push("</br><label style=color:red;font-weight:normal;>&nbsp;&nbsp;&nbsp;of any Generic supplied by the Pharmacy.</label>");
        strPrindData.push("</br>");
        strPrindData.push("</br><label style=color:red;font-weight:normal;>** This is a 'suggested' Drug name and is NOT BINDING on the patient to use the particular brand prescribed above.</label>");
    }
        //end


    var OtherTeatAdvise = "";

    OtherTeatAdvise = $('#txtAdAlterMedDetails').val().trim();

    if (OtherTeatAdvise.trim() !== "") {
        strPrindData.push("</br></br><label style=color:blue;font-weight:bold><u>Advice </u>: </label>" + OtherTeatAdvise);
        strPrindData.push("</br>");
    }


    strPrindData.push("<body></html>");



        //strPrindData.push("<html><body>");

        //strPrindData.push( "<div style=text-align:center;>" + "Partial Reproduction of Report not permitted. This report relates to sample received by the laboratory." + "</div>"
        //                     + "<hr>" +  "<div style=float:left;>" +  "<table><tr><td>Print Time</td><td>" + DateTime.Now.ToString("HH:mm:ss") + "</td><tr></table>" + "</div>"
        //                        +  "<div style=float:right;>" + "<table><tr><td>Print Date</td><td>" + DateTime.Now.ToShortDateString() + "</td><tr></table>" + "</div>")

        //strPrindData.push("<body></html>");

    return strPrindData.join("");

}
//printdata end

//Transaction Save Function
function SaveRecord() {
    try {
        $('#txtICDNM').attr('disabled', false);
        $('#txtICDCD').attr('disabled', false);
        // var can = document.getElementById('canOnExam');
        if ($('#spCONNO').text().trim() === "") {
            $.messager.alert("Information", "Consult Number empty, save is not possible. Please try again.");
            return false;
        }


        var selComplaintData = $.grep($('#gvComplaints').getRowData(), function (e) { return e.CHECK == 'True' });// && e.DURATION != "" 
        var selPerMedData = $.grep($('#gvPersonalMedical').getRowData(), function (e) { return e.CHECK == 'True'; });
        var selPerAdditData = $.grep($('#gvPersonal').getRowData(), function (e) { return e.CHECK == 'True'; });
        var selTreatment = $.grep($('#gvAdvice').getRowData(), function (e) { return e.DRUGNM.trim() !== ''; });
        if (selTreatment.length > 0) {
            for (var i = 0; i < selTreatment.length; i++) {
                selTreatment[i]["RM"] = "";
            }
        }
        var selFamily = $.grep($('#gvFamily').getRowData(), function (e) { return e.NAME.trim() !== ''; });
        var selInvest = $.grep($('#GvService').getRowData(), function (e) { return e.TESTNAME.trim() !== ''; });

        //if (!validComplaints(selComplaintData) || !validPerAddict(selPerAdditData) || !validPerMedical(selPerMedData) || !validFamily(selFamily) || !validTreatRec(selTreatment)) {
        //    return false;
        //}

        var arrNotes = [];
        for (var i = 0; i < $('#ulNewNotes li').length; i++) {
            arrNotes.push({ NOTES: $('#ulNewNotes li')[i].innerText });
        }
        var Altermedyn = "";
        if ($('#chkPerMedOthers').prop('checked', true)) {
            Altermedyn = "Y";
        }
        else {
            Altermedyn = "N";
        }

        var Data = [];
        Data.push({ name: "TRANNO", value: $('#spCONNO').text() });
        Data.push({ name: "MRNO", value: $('#spMRNO').text() });
        Data.push({ name: "DoctorCode", value: DoctorCode });//drcode //$('#spDoctCode').text()
        Data.push({ name: "CREATEDBY", value: CreatedBy });//doctor id
        Data.push({ name: "Weight", value: $('#txtWeight').val() });
        Data.push({ name: "Height", value: $('#txtHeight').val() });
        Data.push({ name: "Temp", value: $('#txtTemp').val() });
        Data.push({ name: "Pulse", value: $('#txtPulse').val() });
        Data.push({ name: "Resp", value: $('#txtResp').val() });
        Data.push({ name: "Bp", value: $('#txtBP').val() });
        Data.push({ name: "VOthers", value: $('#txtVitalOthers').val() });
        Data.push({ name: "Diagnosis", value: $('#txtDiagnosis').val() });
        Data.push({ name: "SurgHist", value: $('#txtSHist').val() });
        Data.push({ name: "PastHist", value: $('#txtPHist').val() });
        Data.push({ name: "ICD", value: $('#txtICDCD').val() });
        Data.push({ name: "Altermedyn", value: Altermedyn });//chkAdAlterMYes,chkAdAlterMNo
        Data.push({ name: "TOthers", value: $('#txtAdAlterMedDetails').val() });
        Data.push({ name: "ExamDet", value: $('#txtEExam').val() });
        Data.push({ name: "Notes", value: JSON.stringify(arrNotes) });
        Data.push({ name: "xmlComplaints", value: JSON.stringify(selComplaintData) });
        Data.push({ name: "xmlAddicts", value: JSON.stringify(selPerAdditData) });
        Data.push({ name: "xmlMedical", value: JSON.stringify(selPerMedData) });
        Data.push({ name: "xmlMedicine", value: JSON.stringify(selTreatment) });
        Data.push({ name: "xmlFamily", value: JSON.stringify(selFamily) });
        Data.push({ name: "xmlInvest", value: JSON.stringify(selInvest) });

        //  Data.push({ name: "sPatPhoto", value: can.toDataURL() });

        Data.push({ name: "PCOthers", value: $('#txtPCOthers').val() });
        Data.push({ name: "PPOthers", value: $('#txtPerOthers').val() });
        Data.push({ name: "InvestOther", value: $('#txtInvest').val() });
        Data.push({ name: "PMOthers", value: $('#txtPerMedOthers').val() });
        Data.push({ name: "TRANMODE", value: $('#spTRANMODE').text() });


        var tempData = "";

        for (i = 0; i < selComplaintData.length; i++) {
            var temp = JSON.stringify($.grep($('#gvComplaints_' + selComplaintData[i].DESCCD + '_per').getRowData(), function (e) { return e.CHECK == 'True'; }));
            if (temp != "") {
                temp = temp.substr(1, temp.length - 2);
                if (temp != "") {
                    if (tempData != "") {
                        temp = temp.replace('}', ',GRPCD="' + selComplaintData[i].DESCCD + '"}');
                        tempData = tempData + "," + temp;
                    }
                    else
                        tempData = temp;
                }
                //if (temp != "")
                //    tempData = tempData + temp;
            }
        }

        if (tempData != "") {
            tempData = "[" + tempData + "]";
        }

        //if (selComplaintData.length == 0 && selPerMedData.length == 0 && selPerAdditData.length == 0 && selTreatment.length == 0 && selFamily.length == 0 && selInvest.length == 0 && tempData.length == 0) {
        //    alert("Please select or enter data to save");
        //    return false;
        //}

        Data.push({ name: "xmlAll", value: tempData });

        $.loader.open();
        $.ajax({
            url: "../DoctorDesk/SaveTran", <%--"<%=Url.Action("SaveTran", "Oncology")%>",--%>
            type: 'post',
            dataType: 'json',
            data: Data,
            success: function (result) {
                $.loader.close();
                if (result.Status == "Success") {
                    $.messager.model = {
                        ok: { text: "Yes", classed: 'btn-success' },
                        cancel: { text: "No", classed: 'btn-danger' }
                    };

                    var mesg = "";
                    var Html = "";
                    if ($("#spTRANMODE")[0].textContent == "1") {
                        mesg = result.Message[0];
                        Html = PrintData(result.Message[1], result.Message[2], result.Message[3])
                    }
                    else if ($("#spTRANMODE")[0].textContent == "2") {
                        mesg = result.Message;
                        Html = PrintData($('#spTranNo').text(), $('#spTranDt').text(), $('#spTranTM').text());
                    }

                    $.messager.confirm('Confirm', mesg + 'Do you want to Print this record?', function (r) {
                        if (r) {
                            PrintListAJAXCommon('<%:Url.Action("PrintPatientReport","DoctorDesk")%>', { strHtml: Html }, $('#spPatName').text(), "");
                    }
                    else {
                        window.location.href = "../DoctorDesk/PatientEntry";
                    }
                    });
            }
            else {
                $.messager.alert('Error', result.Message);
            }
            },
            error: function (xhr, textStatus, errorThrown) {
                $.loader.close();
                alert(textStatus);
            }

        });
} catch (e) {
    alert(e.message);

}

}

function ClrIpUsrCntrl() {


}
function validComplaints(selCompData) {
    //Complaints Data Validation
    // var selCompData = $.grep($('#gvComplaints').getRowData(), function (e) { return e.CHECK == 'True'; });

    for (var i = 0; i < selCompData.length; i++) {
        if (selCompData[i].DURATION == '') {
            //var iRow = jQuery('#gvComplaints tr:eq(' + selCompData[i].DESCCD + ')').attr('id');
            $('.nav-tabs a[href="#tabPresentComp"]').tab('show');
            //$('#gvComplaints').editCell(iRow, 3, true);
            $('#gvComplaints').editCell(selCompData[i].DESCCD, 4, true);
            return false;
        }
        else if (selCompData[i].DURTYPE == '') {
            //var iRow = jQuery('#gvComplaints tr:eq(' + selCompData[i].DESCCD + ')').attr('id');
            $('.nav-tabs a[href="#tabPresentComp"]').tab('show');
            //$('#gvComplaints').editCell(iRow, 4, true);
            $('#gvComplaints').editCell(selCompData[i].DESCCD, 5, true);
            return false;
        }
    }
    if ($('#chkPCOthers').prop('checked') && $('#txtPCOthers').val().trim() === "") {
        $('#txtPCOthers').addClass('ErrorClass');
        $('.nav-tabs a[href="#tabPresentComp"]').tab('show')
        return false;
    }
    else {
        $('#txtPCOthers').removeClass('ErrorClass');
    }
    return true;
}
function validVital() {
    var count = 0;


    for (var i = 0; i < $('#tabVital .required input[type=text]').length; i++) {
        if ($('#tabVital .required input[type=text]')[i].value.length <= 0) {
            $($('#tabVital .required input[type=text]')[i]).addClass('ErrorClass');
            count += 1;
        }
        else {
            $($('#tabVital .required input[type=text]')[i]).removeClass('ErrorClass');
        }
    }
    if (count > 0) {
        $('.nav-tabs a[href="#tabVital"]').tab('show');
        return false;
    }
    else {
        return true;
    }

}
function validPerAddict(selCompData) {
    // personal Info Validation

    //  var selCompData = $.grep($('#gvPersonal').getRowData(), function (e) { return e.CHECK == 'True'; });
    for (var i = 0; i < selCompData.length; i++) {
        if (selCompData[i].STARTAGE.trim() == '' && selCompData[i].ADDICTCD != '04') {
            //var iRow = jQuery('#gvPersonal tr:eq(' + selCompData[i].ADDICTCD + ')').attr('id');
            $('.nav-tabs a[href="#tabPersonalInfo"]').tab('show');
            //$('#gvPersonal').editCell(iRow, 3, true);
            $('#gvPersonal').editCell(selCompData[i].ADDICTCD, 3, true);
            return false;
        }
        //else if (selCompData[i].STOPAGE.trim() == '' && selCompData[i].ADDICTCD != '04') {
        //    //var iRow = jQuery('#gvPersonal tr:eq(' + selCompData[i].ADDICTCD + ')').attr('id');
        //    $('.nav-tabs a[href="#tabPersonalInfo"]').tab('show');
        //    //$('#gvPersonal').editCell(iRow, 4, true);
        //    $('#gvPersonal').editCell(selCompData[i].ADDICTCD, 4, true);
        //    return false;
        //}
    }
    if ($('#chkPerOthers').prop('checked') && $('#txtPerOthers').val().trim() === "") {
        $('#txtPerOthers').addClass('ErrorClass');
        $('.nav-tabs a[href="#tabPersonalInfo"]').tab('show')
        return false
    }
    else {
        $('#txtPerOthers').removeClass('ErrorClass');
    }
    return true;

}
function validPerMedical(selCompData) {
    // personal Info Validation

    // var selCompData = $.grep($('#gvPersonalMedical').getRowData(), function (e) { return e.CHECK == 'True'; });
    for (var i = 0; i < selCompData.length; i++) {
        if (selCompData[i].DURATION.trim() == '' && selCompData[i].MEDCD != '04') {
            //var iRow = jQuery('#gvPersonalMedical tr:eq(' + selCompData[i].MEDCD + ')').attr('id');
            $('.nav-tabs a[href="#tabPersonalInfo"]').tab('show');
            //$('#gvPersonalMedical').editCell(iRow, 3, true);
            $('#gvPersonalMedical').editCell(selCompData[i].MEDCD, 3, true);
            return false;
        }
        else if (selCompData[i].DURTYPE.trim() == '' && selCompData[i].MEDCD != '04') {
            //var iRow = jQuery('#gvPersonalMedical tr:eq(' + selCompData[i].MEDCD + ')').attr('id');
            $('.nav-tabs a[href="#tabPersonalInfo"]').tab('show');
            //$('#gvPersonalMedical').editCell(iRow, 4, true);
            $('#gvPersonalMedical').editCell(selCompData[i].MEDCD, 4, true);
            return false;
        }
        else if (selCompData[i].ONREGTREATYN.trim() == '' && selCompData[i].MEDCD != '04') {
            //var iRow = jQuery('#gvPersonalMedical tr:eq(' + selCompData[i].MEDCD + ')').attr('id');
            $('.nav-tabs a[href="#tabPersonalInfo"]').tab('show')
            //$('#gvPersonalMedical').editCell(iRow, 5, true);
            $('#gvPersonalMedical').editCell(selCompData[i].MEDCD, 5, true);
            return false;
        }
    }
    if ($('#chkPerMedOthers').prop('checked') && $('#txtPerMedOthers').val().trim() === "") {
        $('#txtPerMedOthers').addClass('ErrorClass');
        $('.nav-tabs a[href="#tabPersonalInfo"]').tab('show')
        return false
    }
    else {
        $('#txtPerMedOthers').removeClass('ErrorClass');
    }
    return true;

}
function validFamily(Family) {
    for (var i = 0; i < Family.length; i++) {
        if (Family[i].AGE.trim() == '') {
            //var iRow = jQuery('#gvFamily tr:eq(' + i + 1 + ')').attr('id');
            $('.nav-tabs a[href="#tabFamHist"]').tab('show')
            //$('#gvFamily').editCell(iRow, 1, true);
            $('#gvFamily').editCell(i + 1, 1, true);
            return false;
        }
        if (Family[i].RELATION.trim() == '') {
            //var iRow = jQuery('#gvFamily tr:eq(' + i + 1 + ')').attr('id');
            $('.nav-tabs a[href="#tabFamHist"]').tab('show')
            //$('#gvFamily').editCell(iRow, 2, true);
            $('#gvFamily').editCell(i + 1, 2, true);
            return false;
        }
        if (Family[i].STATUS.trim() == '') {
            //var iRow = jQuery('#gvFamily tr:eq(' + i + 1 + ')').attr('id');
            $('.nav-tabs a[href="#tabFamHist"]').tab('show')
            //$('#gvFamily').editCell(iRow, 3, true);
            $('#gvFamily').editCell(i + 1, 3, true);
            return false;
        }
        if (Family[i].DISEASES.trim() == '') {
            //var iRow = jQuery('#gvFamily tr:eq(' + i + 1 + ')').attr('id');
            $('.nav-tabs a[href="#tabFamHist"]').tab('show')
            //$('#gvFamily').editCell(iRow, 4, true);
            $('#gvFamily').editCell(i + 1, 4, true);
            return false;
        }
        if (Family[i].DURATION.trim() == '') {
            //var iRow = jQuery('#gvFamily tr:eq(' + i + 1 + ')').attr('id');
            $('.nav-tabs a[href="#tabFamHist"]').tab('show')
            //$('#gvFamily').editCell(iRow, 5, true);
            $('#gvFamily').editCell(i + 1, 5, true);
            return false;
        }
        if (Family[i].DURTYPE.trim() == '') {
            //var iRow = jQuery('#gvFamily tr:eq(' + i + 1 + ')').attr('id');
            $('.nav-tabs a[href="#tabFamHist"]').tab('show')
            //$('#gvFamily').editCell(iRow, 6, true);
            $('#gvFamily').editCell(i + 1, 6, true);
            return false;
        }

    }
    return true;
}

function validObstric() {
    //if ($('#divPostMono input:checked').val() === undefined) {
    //    $.messager.alert("Information", "Please Select Post-Menopausal.", 'chkOstricYes');
    //    $('.nav-tabs a[href="#tabObsHist"]').tab('show');
    //    return false;
    //}
    //if ($('#divMarridYN input:checked').val() === undefined) {
    //    $.messager.alert("Information", "Please Select Married .", 'chkOMarrideYes');
    //    $('.nav-tabs a[href="#tabObsHist"]').tab('show')
    //    return false;
    //}
    //else if ($('#divMarridYN input:checked').val() == "Y" && $('#divNulliPara input:checked').val() === undefined) {
    //    $.messager.alert("Information", "Please Select Nullipara.", 'chkONulliparaYes');
    //    $('.nav-tabs a[href="#tabObsHist"]').tab('show')
    //    return false;

    //}
    return true;

}
function validTreatRec(selCompData) {
    //Complaints Data Validation
    // selCompData = $.grep(selCompData, function (e) { return e.DRUGNM.trim() !== ''; });

    for (var i = 0; i < selCompData.length; i++) {
        if (selCompData[i].DOSSAGE == '') {
            //var iRow = jQuery('#gvTreatment tr:eq(' + selCompData[i].ID + ')').attr('id');
            $('.nav-tabs a[href="#tabMedi"]').tab('show')
            //$('#gvTreatment').editCell(iRow, 3, true);
            $('#gvAdvice').editCell(selCompData[i].ID, 2, true);
            return false;
        }
        else if (selCompData[i].DAYS == '') {
            //var iRow = jQuery('#gvTreatment tr:eq(' + selCompData[i].ID + ')').attr('id');
            $('.nav-tabs a[href="#tabMedi"]').tab('show')
            //$('#gvTreatment').editCell(iRow, 4, true);
            $('#gvAdvice').editCell(selCompData[i].ID, 3, true);
            return false;
        }
        else if (selCompData[i].INT1 == 'N' && selCompData[i].INT2 == 'N' && selCompData[i].INT3 == 'N' && selCompData[i].INT4 == 'N' && selCompData[i].INT5 == 'N') {
            //var iRow = jQuery('#gvTreatment tr:eq(' + selCompData[i].ID + ')').attr('id');
            $('.nav-tabs a[href="#tabMedi"]').tab('show')
            $.messager.alert("Information", "Please Select In Take For " + selCompData[i].DRUGNM);
            return false;
        }
    }
    if (selCompData.length > 0) {
        if ($('#divAlterMed input:checked').val() == undefined) {
            $('.nav-tabs a[href="#tabMedi"]').tab('show')
            $.messager.alert("Information", "Please Select Alternative Medicine", 'chkAdAlterMYes');
            return false;
        }
    }
    return true;

}
function validInvestigation() {
    return true;

}
function validGenExam() {
    return true;
}
function ResetGrid() {
    //$('#gvComplaints').clearGridData();
    //$('#gvComplaints').setGridParam({
    //    data: gPreCompdata, subGrid: true,
    //    subGridOptions: { reloadOnExpand: true }
    //}).trigger('reloadGrid');
    CreateCompalintGrid();
    BindComplaintGridOnLoad();
    $('#gvComplaints').clearGridData();
    $('#gvPersonal').clearGridData();
    $('#gvPersonal').setGridParam({ data: gPersonaldata }).trigger('reloadGrid');
    $('#gvPersonalMedical').clearGridData();
    $('#gvPersonalMedical').setGridParam({ data: gPerMeddata }).trigger('reloadGrid');
    $('#gvTreatment').clearGridData();
    $('#gvTreatment').setGridParam({ data: gTreatmentdata }).trigger('reloadGrid');
    $('#gvAdvice').clearGridData();
    $('#gvAdvice').setGridParam({ data: gAdvicedata }).trigger('reloadGrid');
    $('#gvFamily').clearGridData();
    $('#gvFamily').setGridParam({ data: gFamilyHis }).trigger('reloadGrid');

}
function ResetAll() {
    $('.CurrentTabContent input:checked').prop('checked', false);
    var prevWeight = $('#txtPrevWeight').val();
    $('.CurrentTabContent input[type=text]').val('');
    $('.CurrentTabContent textarea').val('');
    $('#txtPrevWeight').val(prevWeight);
    hideAllDiv();
    $('#gvComplaints').clearGridData();
    $('#gvComplaints').setGridParam({
        data: gPreCompdata, subGrid: true,
        subGridOptions: { reloadOnExpand: true }
    }).trigger('reloadGrid');
    //$('#gvPersonal').clearGridData();
    //$('#gvPersonal').setGridParam({ data: gPersonaldata }).trigger('reloadGrid');
    //$('#gvPersonalMedical').clearGridData();
    //$('#gvPersonalMedical').setGridParam({ data: gPerMeddata }).trigger('reloadGrid');
    $('#gvTreatment').clearGridData();
    $('#gvTreatment').setGridParam({ data: gTreatmentdata }).trigger('reloadGrid');
    $('#gvAdvice').clearGridData();
    $('#gvAdvice').setGridParam({ data: gAdvicedata }).trigger('reloadGrid');
}

    </script>



    <style type="text/css">
        .SubGridRow {
            background-color: rgba(245, 105, 23, 0.69);
        }

        .subgrid-cell {
            display: none;
        }

        #mdPrint {
            position: fixed;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            overflow: hidden;
        }

        .md-dialog {
            position: fixed;
            margin: 0;
            width: 100%;
            height: 100%;
            padding: 0;
        }

        .md-content {
            position: absolute;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            border: 2px solid #3c7dcf;
            border-radius: 0;
            box-shadow: none;
        }

        .md-header {
            position: absolute;
            top: 0;
            right: 0;
            left: 0;
            height: 35px;
            padding: 10px;
            background: #6598d9;
            border: 0;
        }

        .md-title {
            color: #fff;
            line-height: 20px;
        }

        .md-body {
            position: absolute;
            top: 20px;
            bottom: 10px;
            width: 100%;
            font-weight: 300;
            overflow: auto;
        }

        .clLastVisit {
            cursor: pointer;
        }

        .required label:after {
            color: red;
            content: '*';
        }

        .ErrorClass {
            border-color: #a94442;
            -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
            box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
        }

        .select2-selection.select2-selection--single.bigdrop {
            height: 20px;
        }

        .bigdrop .select2-selection__rendered {
            height: 18px !important;
            line-height: 18px !important;
        }

        .bigdrop .select2-selection__arrow {
            height: 9px !important;
        }



        #lnkNew:hover {
            cursor: pointer !important;
        }

        #lnkNewNotes:hover, #lnkAddComp:hover {
            cursor: pointer !important;
        }

        .fa-calendar {
            cursor: pointer;
        }

        .ui-jqgrid .ui-jqgrid-htable th {
            text-align: center;
        }

        .ui-datepicker table {
            font-size: 11px;
        }

        .ui-datepicker .ui-datepicker-title select {
            font-size: 12px;
        }

        .ui-widget button {
            font-size: 12px;
        }

        .ui-datepicker td .ui-state-default {
            padding: 2px !important;
        }

        .headerBorder {
            border-style: solid;
            border: none;
            border-bottom: 1px groove #b9b5b5;
            margin-bottom: 0px;
        }

        .headerTopBorder {
            border-style: solid;
            border: none;
            border-top: 1px groove #b9b5b5;
            margin-bottom: 0px;
            border-bottom-left-radius: 0px !important;
            border-top-left-radius: 0px !important;
            border-bottom-right-radius: 0px !important;
            border-top-right-radius: 0px !important;
        }

        .SlimScrollContent {
            padding: 2px !important;
        }

        .slimScrollDiv label {
            font-size: 12px;
            margin: 0px !important;
        }

        .nav-tabs-custom > .nav-tabs.pull-right > li > a {
            padding: 1px;
        }

        .nav-tabs-custom > .nav-tabs > li > a {
            padding: 1px;
        }

        .marginBottom2 {
            margin-bottom: 2px;
        }

        .marginLeft2 {
            margin-left: 2px;
        }

        .marginRight2 {
            margin-right: 2px;
        }

        .padRight3 {
            padding-right: 3px;
        }

        .no-pad-left {
            padding-left: 0px !important;
        }

        .no-pad-bottom {
            padding-bottom: 0px !important;
        }

        .no-pad-Right {
            padding-right: 0px !important;
        }

        .pad2 {
            padding: 2px !important;
        }

        .no-pad-top {
            padding-top: 0px !important;
        }


        #divLastVisit {
            max-height: 80px;
            padding-left: 5px !important;
        }

        textarea {
            resize: none;
        }



        @media (min-width: 768px) {
            #divLastVisit {
                min-height: 200px;
                max-height: 200px;
            }
        }

        @media (min-width: 992px) {
            #divLastVisit {
                min-height: 378px;
                max-height: 333px;
            }

            .CurrentTabContent {
                min-height: 379px;
            }

            .currentPatTabContent {
                min-height: 98px;
                max-height: 98px;
                overflow: hidden;
            }

            .AllTabContent {
                max-height: 325px;
                overflow: auto;
            }

            .divChifcompalints {
                width: 24%;
            }

            .divChiefText {
                width: 76%;
                padding-left: 17px !important;
            }
        }

        @media (min-width: 1200px) {
            #divLastVisit {
                min-height: 378px;
                max-height: 333px;
            }

            .CurrentTabContent {
                min-height: 379px;
            }

            .currentPatTabContent {
                min-height: 98px;
                max-height: 98px;
                overflow: hidden;
            }

            .AllTabContent {
                max-height: 350px;
                overflow: auto;
            }

            .divChifcompalints {
                width: 24%;
            }

            .divChiefText {
                width: 76%;
                padding-left: 17px !important;
            }
        }



        input:read-only {
            background-color: white !important;
            cursor: not-allowed;
        }

        input:-moz-read-only { /* For Firefox */
            background-color: white !important;
            cursor: not-allowed;
        }

        textarea:read-only {
            background-color: white !important;
            cursor: not-allowed;
        }

        textarea:-moz-read-only { /* For Firefox */
            background-color: white !important;
            cursor: not-allowed;
        }

        .clLastVisit span {
            font-size: 13px;
        }
        /*For Test Search*/
        .searchlistclass {
            list-style-type: none;
            list-style-position: inside;
            overflow: auto;
        }

        .searchdivclass {
            position: absolute;
            top: 20px;
            z-index: 100;
            /*background: radial-gradient(#f47b02, #ff7b00);*/
            display: inline-block;
            border-style: solid;
            border-color: #f47b02;
        }

        ul.searchlistclass li {
            position: relative;
            left: -20px;
        }

        #ulNewNotes {
            display: inline;
            list-style: none;
        }

            #ulNewNotes li {
                display: inline;
            }

                #ulNewNotes li:after {
                    content: "";
                }

                #ulNewNotes li:last-child:after {
                    content: "";
                }
    </style>

</asp:Content>
