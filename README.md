# POC for Scripting with Apex

## Scripting with Apex?
Ok. Not really. What I'm talking about is using Execute Anonymous as a de facto scripting tool in conjunction with Salesforce DX CLI and the DX workflow. 

In this use case, I'm using execute anonymous to load scratch org data in a case where the standard data plan falls down: namely populating an object hierarchy that is three levels deep with data, where the middle level is automatically populated via a trigger. 

## Resources
For examples, check in the `apexscripts` directory. 

FYI, `.apxs` is not an officially sanctioned file extension for SFDX. But I like it so I'm using it. 

## Usage

Requires installation of Salesforce DX. See the Salesforce DX *Getting Started* and *Developer Guide* on developer.salesforce.com. 

To see this particular use case start by cloning this project. 

    > git clone git@github.com:pchittum/test-script-apex.git

Next martial up your org (presuming all is right with your dx installation)

    > sfdx force:org:create -a test-script-apex -f config/project-scratch-def-json -s

    > sfdx force:user:permset:assign -n test_Script_Apex

Now lets go and run the apex script:

    > sfdx force:apex:execute -f loaddata.apxs --loglevel debug

You will now have populated the data. To test correct load: 

    > sfdx force:data:soql:query  -q 'SELECT Id,Name,test_Child__r.Name,test_Child__r.test_Parent__r.Name FROM test_Grandchild__c'

    ID                  NAME                                             TEST_CHILD__R.NAME  TEST_CHILD__R.TEST_PARENT__R.NAME
    ──────────────────  ───────────────────────────────────────────────  ──────────────────  ─────────────────────────────────
    a023E000002kZsuQAE  Grandchild of Parent1 Child of Child of Parent1  Child of Parent1    Parent1
    a023E000002kZsvQAE  Grandchild of Parent2 Child of Child of Parent2  Child of Parent2    Parent2

