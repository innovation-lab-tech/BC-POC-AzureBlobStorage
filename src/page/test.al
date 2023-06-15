// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!
//?sv=2022-11-02&ss=bfqt&srt=co&sp=rwdlacupiytfx&se=2023-06-29T17:05:09Z&st=2023-05-12T09:05:09Z&spr=https&sig=V1pxwY1rKjBZNfF4OAHgKJ3WTl29h3wOjlPfZqwZtYE%3D jusqu 30/06

page 50104 Test
{
    Caption = 'Blob test';
    ApplicationArea = all;

    trigger OnOpenPage();
    var
        response: Codeunit "ABS Operation Response";
        containers: Record "ABS Container";
        content: Record "ABS Container Content";
        Txt: Text;

    begin
        Authorization := StorageServiceAuthorization.CreateSharedKey('HPjctmxjRsJmW5nvDdADpad8eMtUHjj5JT1LMZGboSNAq7QYwhuMVOkSQknnyF7N9p1+LBrJmF6d+AStmleTdg==');
        ContainerClient.Initialize('testvmr', Authorization);
        response := ContainerClient.CreateContainer('InnovBlobStorage');
        response := ContainerClient.ListContainers(containers);
        if response.IsSuccessful() then begin
            if containers.findset() then
                repeat
                    message('%1', containers.Name);
                until containers.next() = 0;
        end else
            message('ABS Error: %1', response.GetError());

        BlobClient.Initialize('testvmr', 'InnovBlobStorage', Authorization);
        response := BlobClient.PutBlobBlockBlobText('BCBlob2', 'This is the content of our blobloblob');
        if not Response.IsSuccessful() then
            message('PutBlobBlobBlob %1', response.GetError());

        response := BlobClient.ListBlobs(content);
        if response.IsSuccessful() then
            if content.findset() then
                repeat
                    message('%1', content.Name);
                    BlobClient.GetBlobAsText(content.Name, Txt);
                    Message('%1', Txt);
                until content.next() = 0;
    end;

    var
        ContainerClient: Codeunit "ABS Container Client";
        BlobClient: Codeunit "ABS Blob Client";
        StorageServiceAuthorization: Codeunit "Storage Service Authorization";
        Authorization: Interface "Storage Service Authorization";
}