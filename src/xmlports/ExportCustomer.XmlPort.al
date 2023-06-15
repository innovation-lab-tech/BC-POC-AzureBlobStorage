xmlport 50101 "Export Cust"
{
    Caption = 'Export Customer';
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(Customer; Customer)
            {
                fieldelement(Name; Customer.Name)
                {
                }
                fieldelement(City; Customer.City)
                {
                }
                fieldelement(No; Customer."No.")
                {
                }
                fieldelement(EMail; Customer."E-Mail")
                {
                }
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
}
