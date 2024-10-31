<jsp:include page="menu2.jsp" />

<form id="productForm" action="choose.jsp" method="post">
    <input type="radio" id="biscuits" name="product" value="biscuits">
    <label for="biscuits">Biscuits</label><br>
    <input type="radio" id="soap" name="product" value="soap">
    <label for="soap">Soap</label><br>
    <input type="radio" id="chocolate" name="product" value="chocolate">
    <label for="chocolate">Chocolate</label><br>
    <input type="radio" id="offerzone" name="product" value="offerzone">
    <label for="offerzone">Offer Zone</label><br>
    <input type="submit" value="Choose">
</form>

<style>
    form {
        max-width: 429px;
        margin: 40px auto;
        padding: 38px 17px;
        border: 1px solid #584a4a;
        border-radius: 9px;
        background-color: #f3d0f059;
    }

    select,
    input[type="text"],
    input[type="submit"] {
        width: 100%;
        padding: 10px;
        margin: 5px 0;
        border-radius: 3px;
        border: 1px solid #ccc;
        box-sizing: border-box;
    }

    input[type="submit"] {
        background-color: #8f50adb3;
        color: white;
        border: none;
        cursor: pointer;
    }

    input[type="submit"]:hover {
        background-color: #0e0c10bd;
    }
</style>
