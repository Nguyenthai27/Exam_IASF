<!DOCTYPE html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>List of Employees</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-3">
    <h2>List of Employees</h2>
    <table class="table">
        <thead>
        <tr>
            <th>ID</th>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <tr th:each="employee : ${employees}">
            <td th:text="${employee.id}"></td>
            <td th:text="${employee.firstName}"></td>
            <td th:text="${employee.lastName}"></td>
            <td>
                <button type="button" class="btn btn-primary btn-sm" th:onclick="'javascript:editEmployee(' + ${employee.id} + ')'">Edit</button>
                <button type="button" class="btn btn-danger btn-sm" th:onclick="'javascript:deleteEmployee(' + ${employee.id} + ')'">Delete</button>
            </td>
        </tr>
        </tbody>
    </table>
    <button type="button" class="btn btn-success" th:onclick="javascript:addEmployee()">Add Employee</button>
</div>

<!-- Modal for Add/Edit Employee -->
<div class="modal fade" id="employeeModal" tabindex="-1" role="dialog" aria-labelledby="employeeModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="employeeModalLabel">Employee Form</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="employeeForm" th:action="@{/employees/saveEmployee}" method="post">
                    <input type="hidden" id="employeeId" name="id" th:field="*{id}">
                    <div class="form-group">
                        <label for="firstName">First Name</label>
                        <input type="text" class="form-control" id="firstName" name="firstName" th:field="*{firstName}" required>
                    </div>
                    <div class="form-group">
                        <label for="lastName">Last Name</label>
                        <input type="text" class="form-control" id="lastName" name="lastName" th:field="*{lastName}" required>
                    </div>
                    <button type="submit" class="btn btn-primary">Save</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.0.7/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script th:inline="javascript">
    /* <![CDATA[ */
    function addEmployee() {
        $('#employeeModalLabel').text('Add Employee');
        $('#employeeId').val('');
        $('#firstName').val('');
        $('#lastName').val('');
        $('#employeeModal').modal('show');
    }

    function editEmployee(id) {
        $('#employeeModalLabel').text('Edit Employee');
        $.ajax({
            type: 'GET',
            url: '/employees/showFormForUpdate',
            data: { 'employeeId': id },
            success: function(data) {
                $('#employeeForm').html(data);
                $('#employeeModal').modal('show');
            },
            error: function() {
                alert('Error fetching employee details.');
            }
        });
    }

    function deleteEmployee(id) {
        if (confirm('Are you sure you want to delete this employee?')) {
            window.location.href = '/employees/deleteEmployee?employeeId=' + id;
        }
    }
    /* ]]> */
</script>
</body>
</html>
