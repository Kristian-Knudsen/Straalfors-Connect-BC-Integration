namespace Nsc.Core.DataExchangeFormats.Xml;

codeunit 1000000 XmlParser
{
    procedure ParseXml(XmlText: Text): XmlDocument
    var
        XmlDoc: XmlDocument;
    begin
        if not XmlDocument.ReadFrom(XmlText, XmlDoc) then
            Error('Failed to parse XML document');

        exit(XmlDoc);
    end;

    procedure GetElement(ParentElement: XmlElement; ChildName: Text): XmlElement
    var
        ChildNode: XmlNode;
    begin
        if ParentElement.SelectSingleNode(ChildName, ChildNode) then
            exit(ChildNode.AsXmlElement());
    end;

    procedure GetElementValue(ParentElement: XmlElement; ChildName: Text): Text
    var
        ChildNode: XmlNode;
    begin
        if ParentElement.SelectSingleNode(ChildName, ChildNode) then
            exit(ChildNode.AsXmlElement().InnerText());
    end;
}