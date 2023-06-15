codeunit 50104 "POCABS_Export Customer"
{
    trigger OnRun()
    begin
        ExportCustomer();
    end;


    local procedure ExportCustomer()
    var
        response: Codeunit "ABS Operation Response";
        containers: Record "ABS Container";
        ExportCustomer: XmlPort "Export Cust";
        TempBlob: Codeunit "Temp Blob";
        Outstr: OutStream;
        Instr: instream;
        BlobStorageSetup: Record "POCABS_BlobStorage Setup";
        InterfaceType: Enum POCABS_Interface;
        sKey: text;
        BlobClient: Codeunit "ABS Blob Client";
        StorageServiceAuthorization: Codeunit "Storage Service Authorization";
        Authorization: Interface "Storage Service Authorization";
    begin
        BlobStorageSetup.get(InterfaceType::ExportCustomer);
        IsolatedStorage.get(BlobStorageSetup.Account, skey);
        Authorization := StorageServiceAuthorization.CreateSharedKey(sKey);
        TempBlob.CreateOutStream(Outstr);
        ExportCustomer.SetDestination(outstr);
        if ExportCustomer.Export() then Begin
            TempBlob.CreateInStream(Instr);
            BlobClient.Initialize(BlobStorageSetup.Account, BlobStorageSetup.Container, Authorization);
            response := BlobClient.PutBlobBlockBlobStream('CustomerExported.xml', Instr);
            If response.IsSuccessful() then Begin
                message('Success')
            end else
                Message(response.GetError());
        End
        else
            message('Error');
    end;




}