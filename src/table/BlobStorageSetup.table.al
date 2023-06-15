table 50100 "POCABS_BlobStorage Setup"
{
    Caption = 'POCABS_BlobStorage Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Interface"; Enum POCABS_Interface)
        {
            Caption = 'Interface';
            DataClassification = SystemMetadata;
        }

        field(2; Account; Text[150])
        {
            Caption = 'Account';
            DataClassification = SystemMetadata;
        }
        field(3; "Shared Key Stored"; Boolean)
        {
            Caption = 'Shared Key Stored';
            DataClassification = SystemMetadata;
        }
        field(4; "Shared key Last Update"; DateTime)
        {
            Caption = 'Shared key Last Update';
            DataClassification = SystemMetadata;
        }
        field(5; "Container"; Text[150])
        {
            Caption = 'Container';
            DataClassification = SystemMetadata;
        }

    }
    keys
    {
        key(PK; "interface")
        {
            Clustered = true;
        }
    }
}
