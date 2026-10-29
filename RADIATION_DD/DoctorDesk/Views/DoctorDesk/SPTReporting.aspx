<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Oncology.Master" Inherits="System.Web.Mvc.ViewPage<OncologyEMR.Models.AllergyModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <html>
    <head>
        <title></title>
    </head>
    <body>

        <div id="MainDiv">

            <%--	  <a href="#test1" style="font-size:10px;">Treatment Advice</a>--%>

            <div id="ContentHolderDiv">
                <div style="margin-bottom:2px;">
                    <table style="" class="tblValidationNote">
                        <tr>
                            <th colspan="2">Wheel Diameter Validation</th>
                        </tr>
                        <tr>
                           
                            <td><3 mm</td>
                            <td>negative</td>
                        </tr>
                        <tr>
                           
                            <td>>=3 mm</td>
                            <td>positive</td>
                        </tr>
                    </table>
                </div>
                <form id="frmSPTReporting">
                    <div id="Head">
                        <table style="width: 100%" class="tblHead">
                            <tr>
                                <th>Sr. No</th>
                                <th style="width: 50%">Allergen</th>
                                <th style="width: 20%">Wheel Diameter(mm)</th>
                                <th style="width: 20%">Results(+ve/-ve)</th>
                            </tr>
                        </table>
                    </div>
                    <div id="ControlAllergen" class="divAllergens">
                        <table style="width: 100%" class="tblAllergens">
                            <tr>
                                <th colspan="5"><span class="fa fa-info-circle infoCls" id="01_Type"></span>Control<span class="fa fa-caret-right spanCls"></span></th>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="1" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Histamine(Positive Control)" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="01" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="2" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Saline(Negative Control)" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="01" name="Type" /></td>
                            </tr>
                        </table>
                    </div>

                    <div id="MitesAllergen" class="divAllergens">
                        <table style="width: 100%" class="tblAllergens">
                            <tr>
                                <th colspan="4"><span class="fa fa-info-circle infoCls" id="02_Type"></span>Mites<span class="fa fa-caret-right spanCls"></span></th>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="3" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Dermatophagoides farinae" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="02" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="4" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Dermatophagoides pteronyssinus" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="02" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="5" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Acarus siro" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="02" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="6" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Blomia tropicalis" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="02" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="7" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Lepidoglyphus destructor" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="02" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="8" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Tyrophagus putrescentiae" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="02" name="Type" /></td>
                            </tr>
                        </table>
                    </div>

                    <div id="MouldsAllergen" class="divAllergens">
                        <table style="width: 100%" class="tblAllergens">
                            <tr>
                                <th colspan="4"><span class="fa fa-info-circle infoCls" id="03_Type"></span>Moulds<span class="fa fa-caret-right spanCls"></span></th>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="9" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Alternaria alternata(Alternaria tenuis)" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="03" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="10" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Apergilus fumigatus" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="03" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="11" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Botrytis cinerea" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="03" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="12" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Cladosporium herbarum" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="03" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="13" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Curvularia lunata" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="03" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="14" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Fusarium moniliforme" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="03" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="15" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Helminthosporium halodes" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="03" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="16" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Mucor mucedo" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="03" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="17" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Penicillium notatum" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="03" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="18" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Pullularia pullulans" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="03" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="19" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Rhizopus nigricans" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="03" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="20" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Serpula lacrymans(Merulius lacrymans)" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="03" name="Type" /></td>
                            </tr>
                        </table>
                    </div>

                    <div id="GrassPollenAllergen" class="divAllergens">
                        <table style="width: 100%" class="tblAllergens">
                            <tr>
                                <th colspan="4"><span class="fa fa-info-circle infoCls" id="04_Type"></span>Grass Pollen<span class="fa fa-caret-right spanCls"></span></th>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="21" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Cynodon dactylon(Bermuda Grass)" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="04" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="22" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Dactylis glomerata(Orchard Grass)" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="04" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="23" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Festuca pratensis(Meadow Fescue)" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="04" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="24" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Holcus lanatus(Velvet Grass)" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="04" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="25" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Lotium perenne(Rye Grass)" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="04" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="26" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Poa pratensis(Kentucky Blue Grass)" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="04" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="27" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Phleum Pratense(Timothy Grass)" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="04" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="28" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Cenchrus ciliaris" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="04" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="29" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Imperata cylindrica" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="04" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="30" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Avena sativa(Oat)" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="04" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="31" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Hordeum vulgare(Barley)" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="04" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="32" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Secale cereale(Rye)" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="04" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="33" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Triticum sativum(Wheat)" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="04" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="34" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Zea mays(Corn)" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="04" name="Type" /></td>
                            </tr>
                        </table>
                    </div>

                    <div id="WeedPollenAllergen" class="divAllergens">
                        <table style="width: 100%" class="tblAllergens">
                            <tr>
                                <th colspan="4"><span class="fa fa-info-circle infoCls" id="05_Type"></span>Weed Pollen<span class="fa fa-caret-right spanCls"></span></th>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="35" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Artemisia vulgaris(Mugwort)" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="05" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="36" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Ambrosia artemisi ifolia(Ragweed)" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="05" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="37" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Parthenium hysterophorus" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="05" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="38" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Xanthium Strumarium(Ccklebur)" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="05" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="39" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Amaranthus spinosus(Spiny Pigweed)" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="05" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="40" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Chenopodium album(Lambs Quarter)" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="05" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="41" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Plantago lancelota(Eng Plantain)" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="05" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="42" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Ricinus communis(Castor)" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="05" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="43" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Taraxacum vulgare(Dandelion)" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="05" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="44" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Urtica dioica" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="05" name="Type" /></td>
                            </tr>

                        </table>
                    </div>

                    <div id="TreePollenAllergen" class="divAllergens">
                        <table style="width: 100%" class="tblAllergens">
                            <tr>
                                <th colspan="4"><span class="fa fa-info-circle infoCls" id="06_Type"></span>tree Pollen<span class="fa fa-caret-right spanCls"></span></th>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="45" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Holoptelea integrifolia" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="06" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="46" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Robibia pseudoacacia(Locust black)" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="06" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="47" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Prosopis Juliflora(Mesquite)" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="06" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="48" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Casuarina equisetfolia(beefwood)" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="06" name="Type" /></td>
                            </tr>


                        </table>
                    </div>

                    <div id="MountaineousPollenAllergen" class="divAllergens">
                        <table style="width: 100%" class="tblAllergens">
                            <tr>
                                <th colspan="4"><span class="fa fa-info-circle infoCls" id="07_Type"></span>Mountaineous Tree Pollen<span class="fa fa-caret-right spanCls"></span></th>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="49" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Acer pseudoplatanus(Maple)" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="07" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="50" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Alnus glutinosa(Alder)" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="07" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="51" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Betula alba(Birch)" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="07" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="52" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Corylus aveilana(Hazel)" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="07" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="53" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Fraxinus Excelsior" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="07" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="54" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Populus alba(Poplar)" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="07" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="55" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Platanus orientalis(Plane tree)" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="07" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="56" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Quercus robur(oak)" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="07" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="57" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Salix caprea(Willow)" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="07" name="Type" /></td>
                            </tr>
                        </table>
                    </div>

                    <div id="AnimalEpitheliaPollenAllergen" class="divAllergens">
                        <table style="width: 100%" class="tblAllergens">
                            <tr>
                                <th colspan="4"><span class="fa fa-info-circle infoCls" id="08_Type"></span>Animal Epithelia <span class="fa fa-caret-right spanCls"></span></th>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="58" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Dog Epithelia" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="08" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="59" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Cat Epithelia" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="08" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="60" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Cow Epithelia" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="08" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="61" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Horse Epithelia" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="08" name="Type" /></td>
                            </tr>

                        </table>
                    </div>

                    <div id="InsectAllergen" class="divAllergens">
                        <table style="width: 100%" class="tblAllergens">
                            <tr>
                                <th colspan="4"><span class="fa fa-info-circle infoCls" id="09_Type"></span>Insects<span class="fa fa-caret-right spanCls"></span></th>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="62" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Blatella germanica" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="09" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="63" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Periplaneta americana" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="09" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="64" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Moth" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="09" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="65" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Mosquito" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="09" name="Type" /></td>
                            </tr>

                        </table>
                    </div>

                    <div id="AdditionalAllergen" class="divAllergens">
                        <table style="width: 100%" class="tblAllergens">
                            <tr>
                                <th colspan="4"><span class="fa fa-info-circle infoCls" id="10_Type"></span>Additional Allergen<span class="fa fa-caret-right spanCls"></span></th>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="62" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Latey" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="10" name="Type" /></td>
                            </tr>

                        </table>
                    </div>
                    <div id="FoodAllergen" class="divAllergens">
                        <table style="width: 100%" class="tblAllergens">
                            <tr>
                                <th colspan="4"><span class="fa fa-info-circle infoCls" id="11_Type"></span>Milk/Egg<span class="fa fa-caret-right spanCls"></span></th>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="67" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Cow's milk" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="11" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="68" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Hens egg(White)" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="11" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="69" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Hense Yolk(Yellow)" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="11" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="70" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Hense Egg(Whole)" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="11" name="Type" /></td>
                            </tr>

                        </table>
                    </div>

                    <div id="FloursSeedsAllergen" class="divAllergens">
                        <table style="width: 100%" class="tblAllergens">
                            <tr>
                                <th colspan="4"><span class="fa fa-info-circle infoCls" id="12_Type"></span>Flours And Seeds<span class="fa fa-caret-right spanCls"></span></th>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="71" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Rice" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="12" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="72" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Wheat Flour" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="12" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="73" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Corn Flour" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="12" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="74" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Say Flour" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="12" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="75" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Barley Flour" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="12" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="76" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Oat Flour" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="12" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="77" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Sesame shred" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="12" name="Type" /></td>
                            </tr>
                        </table>
                    </div>


                    <div id="MeatAllergen" class="divAllergens">
                        <table style="width: 100%" class="tblAllergens">
                            <tr>
                                <th colspan="4"><span class="fa fa-info-circle infoCls" id="13_Type"></span>Meat<span class="fa fa-caret-right spanCls"></span></th>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="78" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Chicken" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="13" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="79" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Mutton" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="13" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="80" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Beef" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="13" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="81" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Pork" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="13" name="Type" /></td>
                            </tr>


                        </table>
                    </div>

                    <div id="SeaFoodAllergen" class="divAllergens">
                        <table style="width: 100%" class="tblAllergens">
                            <tr>
                                <th colspan="4"><span class="fa fa-info-circle infoCls" id="15_Type"></span>Sea Food<span class="fa fa-caret-right spanCls"></span></th>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="82" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Shrimp(Prawn)" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="14" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="83" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Lobster" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="14" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="84" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Crab" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="14" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="85" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Carp" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="14" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="86" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Cod" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="14" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="87" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Mussel" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="14" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="88" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Salmon" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="14" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="89" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Sole" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="14" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="90" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Tuna" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="14" name="Type" /></td>
                            </tr>

                        </table>
                    </div>

                    <div id="NutsAllergen" class="divAllergens">
                        <table style="width: 100%" class="tblAllergens">
                            <tr>
                                <th colspan="4"><span class="fa fa-info-circle infoCls" id="16_Type"></span>Nuts<span class="fa fa-caret-right spanCls"></span></th>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="91" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Peanuts" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="15" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="92" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Walnut" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="15" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="93" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Almond" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="15" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="94" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Cashewnut" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="15" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="95" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Pistachio" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="15" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="96" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Hazel nut" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="15" name="Type" /></td>
                            </tr>

                        </table>
                    </div>


                    <div id="FruitsAllergen" class="divAllergens">
                        <table style="width: 100%" class="tblAllergens">
                            <tr>
                                <th colspan="4"><span class="fa fa-info-circle infoCls" id="17_Type"></span>Fruits<span class="fa fa-caret-right spanCls"></span></th>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="97" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Orange" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="16" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="98" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Grape" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="16" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="99" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Pineapple" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="16" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="100" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Banana" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="16" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="101" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Tomato" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="16" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="102" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Clementine" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="16" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="103" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Green Pepper" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="16" name="Type" /></td>
                            </tr>
                        </table>
                    </div>

                    <div id="VegetablesAllergen" class="divAllergens">
                        <table style="width: 100%" class="tblAllergens">
                            <tr>
                                <th colspan="4"><span class="fa fa-info-circle infoCls" id="18_Type"></span>Vegetables<span class="fa fa-caret-right spanCls"></span></th>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="104" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Asparagus" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="17" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="105" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Cauliflower" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="17" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="106" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Pea" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="17" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="107" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Spinach" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="17" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="108" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Potato" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="17" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="109" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Brinjal(Eggplant)" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="17" name="Type" /></td>
                            </tr>

                        </table>
                    </div>

                    <div id="SpicesPulsesAllergen" class="divAllergens">
                        <table style="width: 100%" class="tblAllergens">
                            <tr>
                                <th colspan="4"><span class="fa fa-info-circle infoCls" id="19_Type"></span>Spices and Pulses<span class="fa fa-caret-right spanCls"></span></th>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="110" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Aniseed" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="18" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="111" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Celery Roots" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="18" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="112" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Carnomile" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="18" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="113" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Paprika" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="18" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="114" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Black lentil(Urad)" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="18" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="115" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Green Lentil(Moong)" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="18" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="116" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Bengal Gram(ChickPea)" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="18" name="Type" /></td>
                            </tr>
                            <tr class="notHeaderTr">
                                <td>
                                    <input type="text" name="CODE" value="117" class="clsNonInputTag" /></td>
                                <td>
                                    <input name="Allergen" value="Toor Dal(Arhar)" class="clsNonInputTag"></td>
                                <td>
                                    <input type="text" class="txtWheelDiameter" name="WheelDiameter" /></td>
                                <td></td>
                                <td style="display: none">
                                    <input type="hidden" value="18" name="Type" /></td>
                            </tr>
                        </table>
                    </div>

                    <div id="divPrint" style="text-align:center;margin-top:4px">
                        <input type="button" id="btnPrintSPT" value="Print" class="btnPrintCls" style="display:none;" />
                    </div>
                    <div>
                        <label id="btnSaveSPTRepoting" style="background-color: transparent; float: right; margin-right: 65px; border-color: transparent;" title="Save">
                            <img src="../Images/check-round.png" style="float: right; bottom: 0px; margin-bottom: 10px; background-color: white; border-radius: 50%; position: fixed;">
                        </label>
                    </div>
                </form>
            </div>

        </div>
    </body>
    </html>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">

    <style>
        .tblHead th {
            text-align: center;
            height: 30px;
            font-size: 14px;
            border-collapse: collapse;
            border: 1px solid gray;
        }

        .tblAllergens {
            width: 100%;
            border-collapse: collapse;
            border: 1px solid gray;
        }

            .tblAllergens td {
                font-size: 12px;
                border-collapse: collapse;
                 border: 1px solid gray;
                text-align: center;
                padding: 3px;
            }

            .tblAllergens th {
               font-size: 14px;
                text-align: center;
                border-collapse: collapse;
                border: 1px solid gray;
            }

            .tblAllergens td:nth-child(1) input {
                text-align: center;
            }

            .tblAllergens td:nth-child(2) {
                width: 50%;
                text-align: left;
            }

            .tblAllergens td:nth-child(3) {
                width: 20%;
                text-align: right;
            }

            .tblAllergens td:nth-child(4) {
                width: 20%;
                text-align: center;
            }

            .tblAllergens tr:first-child {
                background-color: #a3e1f1;
            }

        .divAllergens {
            margin-top: 10px;
        }

        .spanCls {
            text-align: right;
            float: right;
            font-size: 24px;
            font-weight: bold;
        }

        .txtWheelDiameter {
            width: 117px;
        }

        .clsNonInputTag {
            border: none;
            width: 100%;
            background-color: transparent;
        }

        .infoCls {
            float: left;
            font-size: 20px;
            display: none;
        }

        .tblValidationNote{
            width:50%;border-collapse:collapse;border:solid 1px gray;
        }

         .tblValidationNote th,td{
             border:solid 1px gray;
             text-align:center;
             color: black;
    font-size: 13px;
         }
         

        #btnPrintSPT{
            width: 73px;
            height: 30px;
            font-size: 17px;
            border-radius: 8px 8px 8px 8px;
            background-color: #398ebd;
        }
    </style>

    <script src="../Scripts/PatList.js"></script>
    <link href="../Scripts/Small-Popover-Modal-Plugin-jQuery/popover.css" rel="stylesheet" />
    <script src="../Scripts/Small-Popover-Modal-Plugin-jQuery/popover.js"></script>
    <script type="text/javascript">
        var urls = "<%=Url.Action("GetDctrClinic", "Account")%>";
        AddClinics(urls);
        $(document).ready(function (e) {
            HoldOn.open();//
            SetPatientDtl();
            SetDataForSPTReporting();
            $('.tblAllergens tr.notHeaderTr').hide();
            $(".txtWheelDiameter").attr('maxlength', '6');


            if ($(window).width() >= 996) {                                            //screen width size comparion
                var menuL = document.getElementById('menuList');
                menuL.style.display = "block";

                var dispLst = document.getElementById('sideList');
                dispLst.style.display = "block";
                $("#slide_sdList").hide();
               // $("#shortCutMenus").css("display", "block");// added by vijeta on 17th april 2018


            }




            // register the handler 
            document.addEventListener('keyup', doc_keyUpForShortCutMenus, false);// added by vijeta on 17th April 2018 for shoetcut keys


            $(".tblAllergens tr:nth-child(1)").click(function () {
                var elem = $(this).nextAll('tr');
                elem.toggle('fast');
                $(this).find('span.spanCls').toggleClass('fa fa-caret-down fa fa-caret-right')
            });

            $(".txtWheelDiameter").change(function () {
                $(this).parent().next().empty();
                if ($(this).val() == "0") {
                    $(this).parent().next().append("<i class='fa fa-minus' aria-hidden='true'></i>")
                }
                else if (Number($(this).val()) == 0 || $(this).val() == "") {
                    $(this).parent().next().empty();
                }
                else if (Number($(this).val()) < 3) {
                    //$(this).parent().next().text("Negative");

                    $(this).parent().next().append("<i class='fa fa-minus' aria-hidden='true'></i><span style='margin-left: 3px; font-size: 15px; font-weight: bold;'>ve</span>");
                }
                else if (Number($(this).val()) >= 3) {
                    //$(this).parent().next().text("Positive");
                    $(this).parent().next().append("<i class='fa fa-plus' aria-hidden='true'></i><span style='margin-left: 3px; font-size: 15px; font-weight: bold;'>ve</span>");

                }

            });

            $(".txtWheelDiameter").keypress(function (evt) {
                var charCode = (evt.which) ? evt.which : evt.keyCode;
                if (charCode != 46 && charCode > 31
                  && (charCode < 48 || charCode > 57))
                    return false;

                return true;
            });


            $("#btnSaveSPTRepoting").click(function () {
                HoldOn.open();//
                var mrNo = ($.session.get('PatMRNO'));
                var tranNo = ($.session.get('PatTRANNO'));
                var doctName = "<%:Session["gDoctName"]%>";//added on 10th July2018
                //var list=$('#frmSPTReporting tr:has(td:nth-child(2) input[type="text"])').filter(function () { return $(this).val(); });

                var list = $('#frmSPTReporting tr:has(td)').filter(function () { return $(this).children()[2].children[0].value != ""; });
                var ar = [];

                list.each(function () {
                    //var val = $(this).children()[2];
                    rowData = $(this).find('input').serializeArray();
                    var rowAr = {};
                    $.each(rowData, function (e, v) {
                        rowAr[v['name']] = v['value'];
                    });
                    ar.push(rowAr);
                });
                console.log(ar);

                $.ajax({
                    url: '../DoctorDesk/SPTReportingTran',
                    datatype: 'json',
                    type: 'post',
                    data: { strAllergenList: JSON.stringify(ar).toString(), strTranNo: tranNo, strMrNo: mrNo, doctName: doctName },
                    success: function (response) {
                        if (response != "")
                            $.messager.alert("Information", response);
                        if (response.indexOf("success") != -1)
                            SetDataForSPTReporting();
                    },complete: function () {
                        HoldOn.close();//
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) { HoldOn.close(); }//
                })
                })
           // });


            $("#btnPrintSPT").click(function () {
                var strMrNo = $.session.get('PatMRNO');
                var strTranNo = $.session.get('PatTRANNO');
                //var doctName = "<%:Session["gDoctName"]%>"
                PrintSPTReportingData(strMrNo, strTranNo);
                });
                
        


        });

        function openWin(Html) {
            var myWindow = window.open('', '', '"<%=Server.MapPath("~/")%>"');
            myWindow.document.write(Html);
            myWindow.document.close();
            myWindow.focus();
            setTimeout(function () {
                myWindow.print();
                myWindow.close();
            }, 100);
         }




        //Save on back button
        //jQuery(document).ready(function ($) {

        //    if (window.history && window.history.pushState) {

        //        window.history.pushState('forward', null, './Allergy');

        //        $(window).on('popstate', function () {
        //            SaveVitals();
        //        });

        //    }
        //});


        function SetDataForSPTReporting() {
            var strMrNo = $.session.get('PatMRNO');
            var strTranNo = $.session.get('PatTRANNO');
            $.ajax({
                url: '../DoctorDesk/GetSptReportingData',
                type: 'POST',
                datatype: 'json',
                data: { strTranNo: strTranNo, strmrNo: strMrNo },
                success: function (response) {
                    if (response != "") {//
                        var Grid = JSON.parse(response);
                        if (Grid.length > 0) {
                            var rowAr = {};

                            $("span.infoCls").hide();
                            $.each(Grid, function (e, v) {
                                var strCode = v["CODE"].toString();
                                var strType = v["Type"].toString();
                                var strAllergen = v["Allergen"].toString();
                                var strWhlDia = v["WheelDiameter"].toString();
                                //alert(v["Allergen"]);

                                $('span[id*="' + strType + '"]').show();
                                $('tr:has(td:has(input[name="CODE"][value="' + strCode + '"]))').children()[2].children[0].value = strWhlDia;

                                if (Number(strWhlDia) >= 3) {
                                    $('tr:has(td:has(input[name="CODE"][value="' + strCode + '"]))').children()[3].innerHTML = "<i class='fa fa-plus' aria-hidden='true'></i>"

                                }
                                else if (Number(strWhlDia) < 3) {
                                    $('tr:has(td:has(input[name="CODE"][value="' + strCode + '"]))').children()[3].innerHTML = "<i class='fa fa-minus' aria-hidden='true'></i>"
                                }
                            });

                        }
                    }
                },
                complete: function () {


                    //added on 10th July 2018
                    var findData = $('.infoCls:visible').find();
                    if (findData.prevObject.length > 0)
                        $("#btnPrintSPT").show();
                    else
                        $("#btnPrintSPT").hide();
                    HoldOn.close();//
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) { HoldOn.close(); }//
            })
        }

        //children('input[name="WheelDiameter"][value!=""]').length > 0
    </script>
</asp:Content>
