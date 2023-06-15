codeunit 50102 TestBlobStorage
{
    Procedure ViewContainers()
    var
        response: Codeunit "ABS Operation Response";
        containers: Record "ABS Container";
        content: Record "ABS Container Content";
        Txt: Text;
        ExportCustomer: XmlPort "Export Cust";
        TempBlob: Codeunit "Temp Blob";
        Outstr: OutStream;
        Instr: instream;
        Customer: Record Customer;

    begin
        Authorization := StorageServiceAuthorization.CreateSharedKey('o3v9hfxUcjrQrEvIlMPozY5BpT8Cpdz3Qir8okgs1CXQnGFza9hePNUHUifESqx1GZ/QOlhQLrtT+AStk7b2jg==');
        ContainerClient.Initialize('innovlababspoc', Authorization);
        response := ContainerClient.CreateContainer('innovblobstorage');

        response := ContainerClient.ListContainers(containers);
        if response.IsSuccessful() then begin
            if containers.findset() then
                repeat
                    message('%1', containers.Name);
                until containers.next() = 0;
        end else
            message('ABS Error: %1', response.GetError());

        TempBlob.CreateOutStream(Outstr);
        ExportCustomer.SetDestination(outstr);
        if ExportCustomer.Export() then Begin
            TempBlob.CreateInStream(Instr);
            BlobClient.Initialize('innovlababspoc', 'innovblobstorage', Authorization);
            response := BlobClient.PutBlobBlockBlobStream('CustomerExported.xml', Instr);
            If response.IsSuccessful() then Begin
                message('Success')
            end else
                Message(response.GetError());
        End
        else
            message('Error');


    end;

    /*procedure test2()
    var
        POCABS_ABSMgt: Codeunit POCABS_ABSMgt;
    begin
        POCABS_ABSMgt.InitializeStorageAccount('innovlababspoc');
        POCABS_ABSMgt.CreateContainer('innovblobstorage');

    end;*/

    var
        ContainerClient: Codeunit "ABS Container Client";
        BlobClient: Codeunit "ABS Blob Client";
        StorageServiceAuthorization: Codeunit "Storage Service Authorization";
        Authorization: Interface "Storage Service Authorization";

}