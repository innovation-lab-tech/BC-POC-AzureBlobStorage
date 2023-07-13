page 50101 "POCABS_BlobStorage Setup List"
{

    ApplicationArea = All;
    Caption = 'BlobStorage Setup';
    PageType = List;
    SourceTable = "POCABS_BlobStorage Setup";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("interface"; Rec.Interface)
                {
                    ApplicationArea = All;
                }
                field(Account; Rec.Account)
                {
                    ToolTip = 'Specifies the value of the Account field.';
                }
                field(Container; Rec.Container)
                {
                    ToolTip = 'Specifies the value of the Container field.';
                }
                field("Shared Key Stored"; Rec."Shared Key Stored")
                {
                    ToolTip = 'Specifies the value of the Shared Key Stored field.';
                }
                field("Shared key Last Update"; Rec."Shared key Last Update")
                {
                    ToolTip = 'Specifies the value of the Shared key Last Update field.';
                }
                field(SharedKey; skey)
                {
                    Caption = 'Shared Key';
                    ApplicationArea = All;
                    HideValue = true;
                }

            }
        }
    }
    actions
    {
        area(Processing)
        {

            action(SetKeyOnIsolatedStorage)
            {
                ApplicationArea = All;
                Caption = 'Set Key';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Export;
                trigger OnAction()

                Begin
                    IsolatedStorage.set(rec.Account, skey);
                    rec."Shared Key Stored" := true;
                    rec."Shared key Last Update" := CurrentDateTime;
                end;
            }
            action(ViewKey)
            {
                ApplicationArea = All;
                Caption = 'View Key';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Export;
                trigger OnAction()
                var
                    lskey: Text[250];
                Begin
                    skey := '';
                    IsolatedStorage.get(rec.Account, lskey);
                    Message(lSkey);
                end;
            }
        }
    }
    var
        Skey: Text[250];

}
