// SPDX-License-Identifier: GPL-3.0 
pragma solidity >=0.7.0 <0.9.0;

contract SupplyChainFactory{
    
    address[] public deployedSupplyChain;

    function createSupplyChain( string memory _supplyChainTitle ) public {
        SupplyChain newSupplyChain = new SupplyChain(   msg.sender, 
                                                                 _supplyChainTitle );

        deployedSupplyChain.push( address(newSupplyChain) );
    }
    
    function getDeployedSupplyChain() public view returns( address[] memory ){
        return deployedSupplyChain;
    }
}

contract SupplyChain{
    
    string public supplyChainTitle;
    address payable public manufactureAddress;
    uint public productExpiredDateInsertedOnChain;
    uint public productArrivalDateInsertedOnChain;
    string public madeWith;
    uint public madeWithInsertedOnChain;
    
    uint public productExpiredDay;
    uint public productExpiredMonth;
    uint public productExpiredYear;
    
    uint public productArrivalDay;
    uint public productArrivalMonth;
    uint public productArrivalYear;

    struct Chain{
        string chainName;
        string productName;
        string productImageLink;
        string ProductImageInformation;
        string chainLocation;
        string tagName;
        string tagInformation;
    }
    Chain[] public chains;
    
    struct CompanyInformation{
        string madeByCompanyName;
        string madeByCompanyLogoLink;
        string madeByCompanyInformation;
        string madeByCompanyLocation;
    }
    CompanyInformation[] public companyInformations;
    
    modifier restrictedOnlyForManufacture(){
        require( msg.sender == manufactureAddress );
        _;
    }

    constructor(    address manager, 
                    string memory _supplyChainTitle 
    ){
        supplyChainTitle = _supplyChainTitle;
        manufactureAddress = payable( manager );
    }
    
    /*
        Insert data by Manufacture 
    */
    function createChain (    
                           
                            string memory _chainName,
                            string memory _productName,
                            string memory _productImageLink,
                            string memory _ProductImageInforrmation,
                            string memory _chainLocation,
                            string memory _tagName,
                            string memory _tagInformation,
                            string memory _madeByCompanyName,
                            string memory _madeByCompanyLogoLink,
                            string memory _madeByCompanyInformation,
                            string memory _madeByCompanyLocation
                            
    ) public restrictedOnlyForManufacture {
        
        Chain memory newChain = Chain({
            chainName: _chainName,
            productName: _productName,
            productImageLink: _productImageLink,
            ProductImageInformation: _ProductImageInforrmation,
            chainLocation: _chainLocation,
            tagName: _tagName,
            tagInformation: _tagInformation
        });
        
        chains.push( newChain );
        
        CompanyInformation memory newCompanyInformation = CompanyInformation({
            madeByCompanyName: _madeByCompanyName,
            madeByCompanyLogoLink: _madeByCompanyLogoLink,
            madeByCompanyInformation: _madeByCompanyInformation,
            madeByCompanyLocation: _madeByCompanyLocation
        });
        
        companyInformations.push( newCompanyInformation );
    }
    
    function insertMadeWith( string memory _madeWith ) public restrictedOnlyForManufacture {
        madeWith = _madeWith;
        madeWithInsertedOnChain = chains.length;
    }
    
    function insertProductExpiredDate(
         uint8 day,
         uint8 month,
         uint16 year
    ) public restrictedOnlyForManufacture {
        
        productExpiredDay = day;
        productExpiredMonth = month;
        productExpiredYear =  year;
        setProductExpiredDateOnChain();
    }
    
    function insertProductArrivalDate(
         uint8 day,
         uint8 month,
         uint16 year
    ) public restrictedOnlyForManufacture {
        productArrivalDay = day;
        productArrivalMonth = month;
        productArrivalYear =  year;
        setProductArrivalDateOnChain();
    }

    function setProductExpiredDateOnChain() public restrictedOnlyForManufacture {
        productExpiredDateInsertedOnChain = chains.length;
    }

    function setProductArrivalDateOnChain() public restrictedOnlyForManufacture {
        productArrivalDateInsertedOnChain = chains.length;
    }

    function getSummary() public view returns(  uint,
                                                address,
                                                string memory
    ){
        return(
            chains.length,
            manufactureAddress,
            supplyChainTitle
        );
    }

    /*
        Destroy Contract by Manufacture
    */
    /*function destroyContract() public restrictedOnlyForManufacture{
        //
        //    sending all funds to the manager public account 
        //
        selfdestruct( manufactureAddress );
    }*/
}