namespace com.sapas;

type Address : {
    Street : String;
    City : String;
    State : String(2);
    PostalCode : String(5);
    Country : String(3);
};

type Category : String(20) default 'Paco' not null; //Ejercicio 3.1 y Ejercicio 3.7

type Structure : {          //Ejercicio 3.2
    Height : Decimal(16, 2);
    Width : Decimal(16, 2);
    Depth : Decimal(16, 2);    
    Quantity : Decimal(16, 2); 
}

type Structures : array of Structure;

type Name : String(100); //Ejercicio 3.5

type Estado : String enum { //Ejercicio 3.6
     activo; 
     inactivo;
};

entity Products {
    key ID : UUID;
    Name : Name;
    Description : String;
    ImageUrl : String;
    ReleaseDate : DateTime default $now;
    DiscontinuedDate : DateTime;
    Price : Decimal(16, 2);
    //measures : Structure; //Ejercicio 3.2
    //measures : Structures //Ejercicio 3.3
    Height : type of Price; //Ejercicio 3.4
    Width : Decimal(16, 2);
    Depth : Decimal(16, 2);    
    Quantity : Decimal(16, 2); 
    //Supplier_ID: UUID; //Ejercicio 4.6 No Administrada
    //ToSupplier : Association to one Suppliers;
    Supplier : Association to Suppliers; //Administrada
    ToSalesData : Association to many SalesData on
    ToSalesData.Productos = $self;
};

entity Suppliers {
    key ID : String;
    Name : type of Products:Name; //Ejercicio3.5
    Address : Address;
    Email : String;
    Phone : String;
    Fax : String;
};

entity Categories {
    key ID : String(1);
    Name : Category; //Ejercicio 3.1
};

entity StockAvailability{
    key ID : Integer;
    Description : String;
};

entity Currencies{
    key ID : String(3);
    Description : String;
};
entity UnitOfMeasures {
    key ID : String(2);
    Description : String;
};

entity DimensionUnits {
    key ID : String(2);
    Description : String;
};

entity Months {
    key ID: String(2);
    Description : String;
    ShortDescription : String(3);
};

entity ProductReviews{
    key ID: UUID;
    key ToProduct_Id: UUID;
    CreatedAt: DateTime;
    Name : String; 
    Rating : Integer;
    Comment : String;
};

entity SalesData{
    key ID : UUID;
    DeliveryDate : DateTime;
    Revenue : Decimal(16, 2);
    Productos : Association to Products;
};

entity City{ //Ejercicio 3.10 / Virtual no aparece en base de datos pero en el Metadata si aparece
    key ID : UUID;
    //@Core.Computed: true //usuario añade datos = false
    //virtual habitants : Integer;
    Name : String;
    Habitants : Integer;
    Area : Decimal(8, 2);
    region : Association to Region; //Ejercicio 4.7
}

extend City with{ //Ejercicio 4.5
    Major : String;
    Languaje : String;
}

entity Region { //Ejercicio 4.7
    key ID         : UUID;
    Name           : String;
}

entity SelCategories as projection on Categories{
    *
}; //Ejercicio 4.1 Crear una proyección

entity Products_lite as select from Products { //3.12 Mbye
    ID,
    Name as NombreProducto,
} where Description like '%1080P%' ;

// entity ParamCities(pCity : String) as //Ejercicio 4.3
//     select
//         Name,
//         Area,
//         Habitants
//     from City
//     where 
//         Name = :pCity;



//Ejercicio 3.8 Ej. cds c db/schema.cds -2 sql. 
//Ejercicio 3.9 : Restricciones: not null, enum. / assert.range sería como una conversion.
//Ejercicio 3.11 @Core.Computed
//Ejercicio 4.2 La vista existe en base de datos y la proyección no. Permite Joins, Where, etc. Las reglas no se heredan en la vista.
                // Proyección hereda las reglas.
//Ejercicio 4.4 En una Base de Datos HANA
//Ejercicio 4.8 City?$expand=Products                

