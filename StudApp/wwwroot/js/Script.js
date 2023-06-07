$(function () {
    AutoCompleteRegistrationNo();
    AutoCompleteEmailAddr();
    AutoCompleteFullName();
    BindClass();
    $("#ddlClassId").on("change", function () {

        if ($("#ddlClassId").val() == "-1") {
            $("#ddlSessionId").find("option").remove();
            $("#ddlSessionId").append("<option value='-1'>--Select--</option>")
        }
        else
            BindSession('0', '0');
    });

    $("#ddlSessionId").on("change", function () {
        if ($("#ddlSessionId").val() == "-1") {
            $("#bodysubject").find("tr").remove();
        }
        else
            BindSubjectTable(0, 0, '', 0);

    });

    GetQueryString();

    SetMaxDOb();

});
function SetMaxDOb() {
    var dtToday = new Date();

    var month = dtToday.getMonth() + 1;
    var day = dtToday.getDate();
    var year = dtToday.getFullYear();
    if (month < 10)
        month = '0' + month.toString();
    if (day < 10)
        day = '0' + day.toString();

    var maxDate = year + '-' + month + '-' + day;
    $('#txtDOB').attr('max', maxDate);
}
function GetQueryString() {
    var url = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
    for (var i = 0; i < url.length; i++) {
        var urlparam = url[i].split('=');
        var value = urlparam[1];

        if (value == undefined)
            value = 1;

        $("input[name=fav_language][value=" + value + "]").attr('checked', 'checked');
        //alert(urlparam[1]);
    }
}
function ChangeLang(lang) {
    window.location.href = "/Student/StudentReg?lang=" + lang;
}

function GetNextStudentRegNo(qType) {
    $.ajax({
        type: "GET",
        url: "/Student/GetNextStudentRegNo",
        success: function (response) {
            $("#txtRegNo").val(response);
            if (qType == 2)
                $('#txtRegNo').attr('readonly', true);
            else
                $('#txtRegNo').attr('readonly', false);
        },
        failure: function (response) {
            alert(response.responseText);
        },
        error: function (response) {
            alert(response.responseText);
        }
    });
}

function ClearData(qType) {
    $('#txtRegNo').attr('readonly', false);
    if (qType == 1) {
        ClearForm();
    }
    if (qType == 2) {
        var regNo = "";
        ClearForm();
        GetNextStudentRegNo(2);
    }
}

function ClearForm() {
    $("#btnDelete").css("display", "none");
    $("#txtRegNo").val("");
    $("#txtEmailAddr").val("");
    $("#txtFullName").val("");
    $("#txtDOB").val("");
    $("#txtDOA").val("");
    $("#ddlGender").val("-1");
    $("#ddlClassId").find("option").remove();
    $("#ddlSessionId").find("option").remove();
    $("#bodysubject").find("tr").remove();
    BindClass();
    //$("#lblMsg").text('');
}

function FillStudentData(qType) {
    var value = '';
    $("#lblMsg").text('');
    if (qType == 1) {
        value = $("#txtRegNo").val();
    }
    else if (qType == 2) {
        value = $("#txtEmailAddr").val();
    }
    else if (qType == 3) {
        value = $("#txtFullName").val();
    }
    $("#btnDelete").css("display", "none");

    $.ajax({
        type: "GET",
        url: "/Student/FillStudentData",
        data: { "value": value, "qType": qType },
        success: function (response) {
            var response = JSON.parse(response);
            console.log(response);
            console.log(response[0].RegNo);

            var searchVal = '';
            $("#txtRegNo").val(response[0].RegNo);
            $("#txtEmailAddr").val(response[0].EmailAddr);
            $("#txtFullName").val(response[0].FullName);
            $("#txtDOB").val(response[0].DOB.substring(0, 10));
            $("#txtDOA").val(response[0].DOA.substring(0, 10));
            $("#ddlGender").val(response[0].Gender);
            $("#ddlClassId").val(response[0].ClassId);

            BindSession(response[0].ClassId, response[0].SessionId)

            searchVal = response[0].RegNo;
            BindSubjectTable(response[0].ClassId, response[0].SessionId, searchVal, qType);

            if (response[0].RegNo != "")
                $("#btnDelete").css("display", "inline");
        },
        failure: function (response) {
            alert(response.responseText);
        },
        error: function (response) {
            alert(response.responseText);
        }
    });
}

function AutoCompleteRegistrationNo() {
    $("#txtRegNo").autocomplete({
        source: function (request, response) {
            $.ajax({
                url: "/Student/GetAutoRegistrationNo",
                type: "POST",
                dataType: "json",
                data: { Prefix: request.term },
                success: function (data) {
                    response($.map(data, function (item) {
                        return { label: item.name, value: item.name };
                    }))
                }
            })
        }
    });
}

function AutoCompleteEmailAddr() {
    $("#txtEmailAddr").autocomplete({
        source: function (request, response) {
            $.ajax({
                url: "/Student/GetAutoEmailAddr",
                type: "POST",
                dataType: "json",
                data: { Prefix: request.term },
                success: function (data) {
                    response($.map(data, function (item) {
                        return { label: item.name, value: item.name };
                    }))
                }
            })
        }
    });
}

function AutoCompleteFullName() {
    $("#txtFullName").autocomplete({
        source: function (request, response) {
            $.ajax({
                url: "/Student/GetAutoFullName",
                type: "POST",
                dataType: "json",
                data: { Prefix: request.term },
                success: function (data) {
                    /*alert(data);*/
                    //console.log(data);
                    response($.map(data, function (item) {
                        //console.log(item.name);
                        return { label: item.name, value: item.name };
                    }))
                }
            })
        }
    });
}

function BindClass() {
    //$("#lblMsg").text('');
    //alert("cl")
    $.ajax({
        type: "GET",
        url: "/Student/GetClassList",
        success: function (response) {
            var jdata = JSON.parse(response);
            $("#ddlClassId").find("option").remove();
            $("#ddlClassId").append(0, "<option value='-1'>--Select--</option>")

            $(jdata).each(function (index, key) {
                $option = "<option value='" + key.Id + "'>" + key.Name + "</option>"
                $("#ddlClassId").append($option);
            });
        },
        failure: function (response) {
            alert(response.responseText);
        },
        error: function (response) {
            alert(response.responseText);
        }
    });
}

function BindSession(ClassId, SessionId) {
    if (ClassId == "0")
        ClassId = $("#ddlClassId").val()
    //$("#lblMsg").text('');
    $.ajax({
        type: "GET",
        url: "/Student/GetSessionList",
        data: { "ClassID": ClassId },
        success: function (response) {
            var data = response;
            var jdata = JSON.parse(data);
            $("#ddlSessionId").find("option").remove();
            $("#ddlSessionId").append("<option value='-1'>--Select--</option>")

            $(jdata).each(function (index, key) {
                $option = "<option value='" + key.Id + "'>" + key.Name + "</option>"
                $("#ddlSessionId").append($option);
            });

            if (ClassId != "0")
                $("#ddlSessionId").val(SessionId);

        },
        failure: function (response) {
            alert(response.responseText);
        },
        error: function (response) {
            alert(response.responseText);
        }
    });
}

function BindSubjectTable(ClassId, SessionId, searchValue, qType) {
    if (ClassId == 0)
        ClassId = $("#ddlClassId").val();
    if (SessionId == 0)
        SessionId = $("#ddlSessionId").val();
    //$("#lblMsg").text('');
    $.ajax({
        type: "GET",
        url: "/Student/GetSubjectList",
        data: { "ClassId": ClassId, "SessionId": SessionId, "searchValue": searchValue, "qType": qType },
        success: function (response) {
            var data = response;
            var jdata = JSON.parse(data);
            $("#bodysubject").find("tr").remove();

            $(jdata).each(function (index, key) {
                $tr = "<tr><td> <button class='btn btn-danger' onclick='Remove(this)' >Remove</button></td>" +
                    "<td> " + key.SubjectNo + "</td>" +
                    "<td> " + key.EngSubjectName + "</td><td> " + key.CrHours + "</td>" +
                    "<td> " + key.TotalMarks + "</td><td> " + key.Remarks + "</td>" +
                    "<td style='display:none;'> " + key.SubjectId + "</td></tr>"
                $("#bodysubject").append($tr);
            });
            ValidateForm();

            if ($("#txtRegNo").val() == "")
                GetNextStudentRegNo(1);
        },
        failure: function (response) {
            alert(response.responseText);
        },
        error: function (response) {
            alert(response.responseText);
        }
    });
}

function Remove(row) {
    $tr = $(row).closest("tr")
    $tr.remove();
}

function ValidateForm() {
    var RegNo = $("#txtRegNo").val();
    var FullName = $("#txtFullName").val();
    var DOB = $("#txtDOB").val();
    var Gender = $("#ddlGender").val();
    var EmailAddr = $("#txtEmailAddr").val();
    var DOA = $("#txtDOA").val();
    var ClassId = $("#ddlClassId").val();
    var SessionId = $("#ddlSessionId").val();

    var emailExp = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([com\co\.\in])+$/; // to validate email id 

    var flag = true;

    if (FullName == "") {
        $("#spnFullName").text("Full name is required field");
        flag = false;
    } else {
        $("#spnFullName").text("");
    }

    if (DOB == "") {
        $("#spnDOB").text("DOB is required field");
        flag = false;
    } else {
        $("#spnDOB").text("");
    }

    if (Gender == "-1") {
        $("#spnGender").text("Gender is required field");
        flag = false;
    } else {
        $("#spnGender").text("");
    }

    if (EmailAddr == "") {
        $("#spnEmailAddr").text("Email Address is required field");

        flag = false;
    } else {
        $("#spnEmailAddr").text("");
    }

    if (EmailAddr != "") {
        if (!EmailAddr.match(emailExp)) {
            $("#spnEmailAddr").text("Invalid Email Id");
            flag = false;
        } else {
            $("#spnEmailAddr").text("");
        }
    }

    if (DOA == "") {
        $("#spnDOA").text("DOA is required field");
        flag = false;
    } else {
        $("#spnDOA").text("");
    }

    if (ClassId == "-1") {
        $("#spnClassId").text("Class is required field");
        flag = false;
    } else {
        $("#spnClassId").text("");
    }

    if (SessionId == "-1") {
        $("#spnSessionId").text("Session is required field");
        flag = false;
    } else {
        $("#spnSessionId").text("");
    }

    if ($('#bodysubject').find('tr').length == 0) {
        $("#spnTblsubject").text("courses are missing for the selected class and session");
        flag = false;
    } else {
        $("#spnTblsubject").text("");
    }

    return flag;
}
function SaveData(qType) {
    if (ValidateForm()) {
        var RegNo = $("#txtRegNo").val();
        var FullName = $("#txtFullName").val();
        var DOB = $("#txtDOB").val();
        var Gender = $("#ddlGender").val();
        var EmailAddr = $("#txtEmailAddr").val();
        var DOA = $("#txtDOA").val();
        var ClassId = $("#ddlClassId").val();
        var SessionId = $("#ddlSessionId").val();

        var Studheader = {};
        var studSubject = [];

        Studheader.StudId = 1;
        Studheader.RegNo = RegNo.trim();
        Studheader.FullName = FullName.trim();
        Studheader.DOB = DOB.trim();
        Studheader.Gender = Gender.trim();
        Studheader.EmailAddr = EmailAddr.trim();
        Studheader.DOA = DOA.trim();
        Studheader.ClassId = ClassId.trim();
        Studheader.SessionId = SessionId.trim();

        $("#bodysubject tr").each(function (index, key) {
            studSubject.push({
                RegNo: $("#txtRegNo").val().trim(),
                SubjectNo: $(key).find('td:eq(1)').html().trim(),
                EngSubjectName: $(key).find('td:eq(2)').html().trim(),
                CrHours: $(key).find('td:eq(3)').html().trim(),
                TotalMarks: $(key).find('td:eq(4)').html().trim(),
                Remarks: $(key).find('td:eq(5)').html().trim(),
                SubjectId: $(key).find('td:eq(6)').html().trim(),
            })
        });

        //console.log(Studheader);
        //console.log(studSubject);

        //var qType = 1;

        $.ajax({
            type: "POST",
            url: "/Student/SaveData",
            data: { "student": Studheader, "studentSubjects": studSubject, "qType": qType },
            success: function (response) {
                $('#txtRegNo').attr('readonly', false);
                if (response == "1") {
                    $("#lblMsg").css("color", "green");
                    $("#lblMsg").text("Record inserted successfully..");
                }
                else if (response == "2") {
                    $("#lblMsg").css("color", "green");
                    $("#lblMsg").text("Record updated successfully..");
                }
                else if (response == "3") {
                    $("#lblMsg").css("color", "green");
                    $("#lblMsg").text("Record deleted successfully..");
                }
                else {
                    $("#lblMsg").css("color", "red");
                    $("#lblMsg").text(response);
                }

                if (qType == 1)
                    ClearForm()
                else if (qType == 2) {
                    window.location.href = "/Home/Index";
                }
            },
            failure: function (response) {
                alert(response.responseText);
            },
            error: function (response) {
                alert(response.responseText);
            }
        });
    }
    else {
        $("#lblMsg").css("color", "red");
        $("#lblMsg").text("Something went wrong");
        return false;
    }
}
