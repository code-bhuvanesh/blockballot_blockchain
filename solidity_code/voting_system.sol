// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;


contract VotingSystem {
    address public admin = 0xbBEC777b5B28055C2820228e22aD9C2F0B792b19;

    
    
    struct Nominee {
        string name;
        uint256 dob; // Date of birth represented as YYYYMMDD
        string politicsName;
        uint256 district;
        uint256 voterid;
        uint256 votes;
        bool isRegistered;
    }

    
    struct NomineeOut {
        string name;
        string politicsName;
        uint256 district;
    }
    
    
    struct Voter {
        string name;
        uint256 aadharNo;
        uint256 voterId;
        uint256 dob; // Date of birth represented as YYYYMMDD
        uint256 district;
        bool isVoted;
        bool isRegistered;
    }

    uint256[] nominiesId;
    Nominee[] public nominiesList;
    uint256[] votersId;
    
    mapping(uint256 => Nominee) public nominees;
    mapping(uint256 => Voter) public voters;
    
    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }
    
    // constructor() {
    //     admin = msg.sender;
    // }
    
    // function setAdmin(address _admin) external {
    //     require(admin == address(0), "Admin already set");
    //     admin = _admin;
    // }
    
    function registerNominee(uint256 _voterId, string memory _name, uint256 _dob, string memory _politicsName, uint256 _district) external onlyAdmin returns (bool) {
        require(!voters[_voterId].isRegistered, "Voter with this Aadhar No already registered");
        require(!nominees[_voterId].isRegistered, "Nominee with this ID already registered");
        
        nominees[_voterId] = Nominee(_name, _dob, _politicsName, _district, _voterId, 0,true);
        nominiesId.push(_voterId);
        nominiesList.push( Nominee(_name, _dob, _politicsName, _district, _voterId, 0,true));

        return true;
    }
    
    function registerVoter(uint256 _aadharNo, uint256 _voterId, string memory _name, uint256 _dob, uint256 _district) external onlyAdmin returns (bool) {
        require(!voters[_aadharNo].isRegistered, "Voter with this Aadhar No already registered");
        
        voters[_voterId] = Voter(_name, _aadharNo, _voterId, _dob, _district, false,true);
        votersId.push(_voterId);

        return true;
    }

    function PutVote(uint256 _voterId, uint256 _nominieVoterId) external returns (bool)
    {
        require(!voters[_voterId].isVoted, "voter has already voted");
        nominees[_nominieVoterId].votes  += 1;
        voters[_voterId].isVoted = true;
        return  true;
    }

    function GetResults() public  view returns ( Nominee[] memory){
       return nominiesList;
    }

    // function GetNominies(uint256 _district)  external pure returns (NomineeOut[] memory ) {
    //     NomineeOut[] memory  out  = new NomineeOut[](nominiesId.length); ;
    //     for(uint256 i = 0; i < nominiesId.length; i++){
            
    //         Nominee memory n = nominiesList[i];
    //         if(n.district ==_district ){
    //             out.push(NomineeOut(n.name,n.politicsName,n.district));
    //         }
    //     }
        
    //     assembly {
    //         mstore(out, outIndex)
    //     }

    //     return  out;
    // }

    function GetNominies(uint256 _district)  external view  returns (NomineeOut[] memory ) {
         NomineeOut[] memory out = new NomineeOut[](nominiesId.length);

        uint256 outIndex = 0;

        for (uint256 i = 0; i < nominiesId.length; i++) {
            Nominee memory n = nominiesList[i];

            if (n.district == _district) {
                out[outIndex] = NomineeOut(n.name, n.politicsName, n.district);

                outIndex++;
            }
        }

        assembly {
            mstore(out, outIndex)
        }

        return out;
    }

}