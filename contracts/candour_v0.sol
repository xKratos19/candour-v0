// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

import "@lukso/lsp-smart-contracts/contracts/LSP7DigitalAsset/LSP7DigitalAsset.sol";

contract Candour is LSP7DigitalAsset{
    constructor(
    string memory _name,
    string memory _symbol
    ) LSP7DigitalAsset(_name,_symbol,msg.sender,false){}

    // address public merchantId;
    address public admin = msg.sender;

    struct ids{
        string brand_id; //in mint
        address brand_address; //in mint
        address customer_id; //later
        uint256 date_of_activation; //in mint
        uint256 date_of_return; //later
        bool hasDeposit; // in mint
        address merchant_id; //later
    }

    mapping(uint256 => ids) id;

    modifier onlyAdmin{
        require(msg.sender == admin,"Not Admin");
        _;
    }

    modifier onlyMerchant(uint256 _id){
        require(msg.sender == id[_id].brand_address || msg.sender == id[_id].merchant_id || msg.sender == admin,"Not the right permisions");
        _;
    }

    function mint(address _to,uint256 _amount, string memory _brand_id,bool _hasDeposit) public onlyAdmin{
        _mint(_to,_amount,true,' ');
        for(uint256 i=1;i<=_amount;i++){
            id[i].brand_address = _to;
            id[i].brand_id = _brand_id;
            id[i].date_of_activation = block.timestamp;
            id[i].hasDeposit = _hasDeposit;
            }
        }

        function setCustomerId(address _customerAddress,uint256 _id) public onlyMerchant(_id){
            id[_id].customer_id = _customerAddress;
        }

        function setActivation(uint256 _id,bool _state) public onlyMerchant(_id){
            id[_id].hasDeposit = _state;
        }

        function setDateOfReturn(uint256 _date,uint256 _id) public onlyMerchant(_id) {
            id[_id].date_of_return = _date;
        } 

        function setMerchantId(uint256 _id, address _merchant) public onlyMerchant(_id){
            id[_id].merchant_id = _merchant;
        }

        function returnBrand(uint256 _id) public view returns(string memory){
            return id[_id].brand_id;
        }

        function returnBrandAddress(uint256 _id) public view returns(address){
            return id[_id].brand_address;
        }

        function returnCustomerId(uint256 _id) public view returns(address){
            return id[_id].customer_id;
        }
        
        function returnTime(uint256 _id) public view returns(uint256){
            return id[_id].date_of_activation;
        }

        function returnReturnData(uint256 _id) public view returns(uint256){

            return id[_id].date_of_return;
        }

        function returnDeposit(uint256 _id) public view returns(bool){
            return id[_id].hasDeposit;
        }

        function returnMerchantId(uint256 _id) public view returns(address){
            return id[_id].merchant_id;
        }
    }
