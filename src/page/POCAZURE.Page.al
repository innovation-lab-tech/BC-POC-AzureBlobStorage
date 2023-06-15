page 50102 POCAZURE
{
    ApplicationArea = All;
    Caption = 'POCAZURE';
    PageType = List;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
        }
    }


    actions
    {
        area(Processing)
        {
            action(ExportCustomer)
            {
                Caption = 'Export Customer';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Codeunit.Run(Codeunit::"POCABS_Export Customer");
                end;
            }


        }
    }

    trigger OnOpenPage()
    var
    // POCABS: Codeunit POCABS;
    begin
        //POCABS.CreateMyFirstBlob();
    end;
}
