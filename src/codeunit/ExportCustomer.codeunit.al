codeunit 50104 "POCABS_Export Customer"
{
    trigger OnRun()
    begin
        ExportCustomer();
    end;


    local procedure ExportCustomer()
    var
        response: Codeunit "ABS Operation Response"; //Cette variable est utilisée pour récupérer le résultat de l'opération de stockage
        ExportCustomer: XmlPort "Export Cust";
        TempBlob: Codeunit "Temp Blob";
        Outstr: OutStream;
        Instr: instream;
        BlobStorageSetup: Record "POCABS_BlobStorage Setup";
        InterfaceType: Enum POCABS_Interface;
        BlobClient: Codeunit "ABS Blob Client"; //Cette variable est utilisée pour réaliser des opération su le blob storage dans notre cas c'est l'envoi du fichier xml
        Authorization: Interface "Storage Service Authorization"; //Cette variable de type interface est utilisée pour stocker l'authentification sur le service de stockage
        ErrExport: Label 'Export Error';
    begin
        BlobStorageSetup.get(InterfaceType::ExportCustomer); // récupération des paramètres de connexion au service de stockage
        BlobStorageSetup.TestField(Account);
        BlobStorageSetup.TestField(Container);
        if BlobStorageSetup."Shared Key Stored" then begin
            Authorization := BlobStorageConnexion(InterfaceType::ExportCustomer, BlobStorageSetup.Account);
            TempBlob.CreateOutStream(Outstr);
            ExportCustomer.SetDestination(outstr);
            if ExportCustomer.Export() then Begin
                TempBlob.CreateInStream(Instr);
                BlobClient.Initialize(BlobStorageSetup.Account, BlobStorageSetup.Container, Authorization); // initialisation du client blob
                response := BlobClient.PutBlobBlockBlobStream('CustomerExported.xml', Instr); // envoi du fichier xml dans le blob storage
                If response.IsSuccessful() then Begin //réccupération du résultat de l'opération
                    message('Success')
                end else
                    Message(response.GetError()); //affichage de l'erreur rencontrée par le client blob storage
            End else
                message(Errexport);
        end;
    end;

    local procedure BlobStorageConnexion(InterfaceType: Enum POCABS_Interface; Account: text): Interface "Storage Service Authorization"
    var
        sKey: text;
        StorageServiceAuthorization: Codeunit "Storage Service Authorization"; //Ce coedunit est chargé de gérer l'authentification sur le service de stockage
    begin
        IsolatedStorage.get(Account, skey); //réccupération de la clé dans l'solatedStorage
        exit(StorageServiceAuthorization.CreateSharedKey(sKey)); //Création de l'authentification mise à jour de la variable de retour
    end;
}