namespace Nsc.Tests.Source.Connect;
using Nsc.Connect;

codeunit 1002001 "NscConnectRequestBuilder Tests"
{
    Subtype = Test;
    TestPermissions = Disabled;

    [Test]
    procedure "PrepareDocumentReturnsExpectedOutput"()
    var
        Nsc: Codeunit "Nsc Request Builder";
        ActualOutput: XmlElement;
    begin
        // Arrange
        // Act
        ActualOutput := Nsc.PrepareDocumentAndReturnRoot();

        // Assert
    end;
}