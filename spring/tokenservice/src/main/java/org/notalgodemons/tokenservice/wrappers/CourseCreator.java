package org.notalgodemons.tokenservice.wrappers;

import java.math.BigInteger;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import org.web3j.abi.TypeReference;
import org.web3j.abi.datatypes.Address;
import org.web3j.abi.datatypes.Function;
import org.web3j.abi.datatypes.Type;
import org.web3j.crypto.Credentials;
import org.web3j.protocol.Web3j;
import org.web3j.protocol.core.RemoteCall;
import org.web3j.protocol.core.RemoteFunctionCall;
import org.web3j.protocol.core.methods.response.TransactionReceipt;
import org.web3j.tx.Contract;
import org.web3j.tx.TransactionManager;
import org.web3j.tx.gas.ContractGasProvider;

/**
 * <p>Auto generated code.
 * <p><strong>Do not modify!</strong>
 * <p>Please use the <a href="https://docs.web3j.io/command_line.html">web3j command line tools</a>,
 * or the org.web3j.codegen.SolidityFunctionWrapperGenerator in the 
 * <a href="https://github.com/web3j/web3j/tree/master/codegen">codegen module</a> to update.
 *
 * <p>Generated with web3j version 4.5.10.
 */
@SuppressWarnings("rawtypes")
public class CourseCreator extends Contract {
    private static final String BINARY = "0x608060405234801561001057600080fd5b50336000806101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff1602179055506106d4806100606000396000f3fe608060405234801561001057600080fd5b50600436106100415760003560e01c80630ee2cb10146100465780631bd4edf3146100905780632e339646146100da575b600080fd5b61004e610148565b604051808273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200191505060405180910390f35b610098610171565b604051808273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200191505060405180910390f35b610106600480360360208110156100f057600080fd5b81019080803590602001909291905050506101d8565b604051808273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200191505060405180910390f35b60008060009054906101000a900473ffffffffffffffffffffffffffffffffffffffff16905090565b6000600160003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060009054906101000a900473ffffffffffffffffffffffffffffffffffffffff16905090565b600080826040516101e890610298565b80828152602001915050604051809103906000f08015801561020e573d6000803e3d6000fd5b50905080600160003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060006101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff16021790555080915050919050565b6103fa806102a68339019056fe608060405234801561001057600080fd5b506040516103fa3803806103fa8339818101604052602081101561003357600080fd5b8101908080519060200190929190505050806000819055505061039f8061005b6000396000f3fe608060405234801561001057600080fd5b50600436106100365760003560e01c80631a6c5b631461003b578063d99a8dc3146100f8575b600080fd5b61007d6004803603602081101561005157600080fd5b81019080803573ffffffffffffffffffffffffffffffffffffffff1690602001909291905050506101b3565b6040518080602001828103825283818151815260200191508051906020019080838360005b838110156100bd5780820151818401526020810190506100a2565b50505050905090810190601f1680156100ea5780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b6101b16004803603602081101561010e57600080fd5b810190808035906020019064010000000081111561012b57600080fd5b82018360208201111561013d57600080fd5b8035906020019184600183028401116401000000008311171561015f57600080fd5b91908080601f016020809104026020016040519081016040528093929190818152602001838380828437600081840152601f19601f820116905080830192505050505050509192919290505050610263565b005b60016020528060005260406000206000915090508054600181600116156101000203166002900480601f01602080910402602001604051908101604052809291908181526020018280546001816001161561010002031660029004801561025b5780601f106102305761010080835404028352916020019161025b565b820191906000526020600020905b81548152906001019060200180831161023e57829003601f168201915b505050505081565b6000544210156102c25780600160003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002090805190602001906102c09291906102c5565b505b50565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f1061030657805160ff1916838001178555610334565b82800160010185558215610334579182015b82811115610333578251825591602001919060010190610318565b5b5090506103419190610345565b5090565b61036791905b8082111561036357600081600090555060010161034b565b5090565b9056fea265627a7a723158209c3a9e3ce5976133109e9a79e0bf250477e3d50d70298a4c09de25581fab0c8d64736f6c634300050c0032a265627a7a7231582095553921f58ee0a4f05febfcc61db528d0c07999ad799a247f4af9cfa1f8ddf364736f6c634300050c0032";

    public static final String FUNC_CREATECOURSE = "createCourse";

    public static final String FUNC_FETCHCOURSEADDRESS = "fetchCourseAddress";

    public static final String FUNC_GETCREATOR = "getCreator";

    protected static final HashMap<String, String> _addresses;

    static {
        _addresses = new HashMap<String, String>();
    }

    @Deprecated
    protected CourseCreator(String contractAddress, Web3j web3j, Credentials credentials, BigInteger gasPrice, BigInteger gasLimit) {
        super(BINARY, contractAddress, web3j, credentials, gasPrice, gasLimit);
    }

    protected CourseCreator(String contractAddress, Web3j web3j, Credentials credentials, ContractGasProvider contractGasProvider) {
        super(BINARY, contractAddress, web3j, credentials, contractGasProvider);
    }

    @Deprecated
    protected CourseCreator(String contractAddress, Web3j web3j, TransactionManager transactionManager, BigInteger gasPrice, BigInteger gasLimit) {
        super(BINARY, contractAddress, web3j, transactionManager, gasPrice, gasLimit);
    }

    protected CourseCreator(String contractAddress, Web3j web3j, TransactionManager transactionManager, ContractGasProvider contractGasProvider) {
        super(BINARY, contractAddress, web3j, transactionManager, contractGasProvider);
    }

    public RemoteFunctionCall<TransactionReceipt> createCourse(BigInteger deadline) {
        final Function function = new Function(
                FUNC_CREATECOURSE, 
                Arrays.<Type>asList(new org.web3j.abi.datatypes.generated.Uint256(deadline)), 
                Collections.<TypeReference<?>>emptyList());
        return executeRemoteCallTransaction(function);
    }

    public RemoteFunctionCall<String> fetchCourseAddress() {
        final Function function = new Function(FUNC_FETCHCOURSEADDRESS, 
                Arrays.<Type>asList(), 
                Arrays.<TypeReference<?>>asList(new TypeReference<Address>() {}));
        return executeRemoteCallSingleValueReturn(function, String.class);
    }

    public RemoteFunctionCall<String> getCreator() {
        final Function function = new Function(FUNC_GETCREATOR, 
                Arrays.<Type>asList(), 
                Arrays.<TypeReference<?>>asList(new TypeReference<Address>() {}));
        return executeRemoteCallSingleValueReturn(function, String.class);
    }

    @Deprecated
    public static CourseCreator load(String contractAddress, Web3j web3j, Credentials credentials, BigInteger gasPrice, BigInteger gasLimit) {
        return new CourseCreator(contractAddress, web3j, credentials, gasPrice, gasLimit);
    }

    @Deprecated
    public static CourseCreator load(String contractAddress, Web3j web3j, TransactionManager transactionManager, BigInteger gasPrice, BigInteger gasLimit) {
        return new CourseCreator(contractAddress, web3j, transactionManager, gasPrice, gasLimit);
    }

    public static CourseCreator load(String contractAddress, Web3j web3j, Credentials credentials, ContractGasProvider contractGasProvider) {
        return new CourseCreator(contractAddress, web3j, credentials, contractGasProvider);
    }

    public static CourseCreator load(String contractAddress, Web3j web3j, TransactionManager transactionManager, ContractGasProvider contractGasProvider) {
        return new CourseCreator(contractAddress, web3j, transactionManager, contractGasProvider);
    }

    public static RemoteCall<CourseCreator> deploy(Web3j web3j, Credentials credentials, ContractGasProvider contractGasProvider) {
        return deployRemoteCall(CourseCreator.class, web3j, credentials, contractGasProvider, BINARY, "");
    }

    public static RemoteCall<CourseCreator> deploy(Web3j web3j, TransactionManager transactionManager, ContractGasProvider contractGasProvider) {
        return deployRemoteCall(CourseCreator.class, web3j, transactionManager, contractGasProvider, BINARY, "");
    }

    @Deprecated
    public static RemoteCall<CourseCreator> deploy(Web3j web3j, Credentials credentials, BigInteger gasPrice, BigInteger gasLimit) {
        return deployRemoteCall(CourseCreator.class, web3j, credentials, gasPrice, gasLimit, BINARY, "");
    }

    @Deprecated
    public static RemoteCall<CourseCreator> deploy(Web3j web3j, TransactionManager transactionManager, BigInteger gasPrice, BigInteger gasLimit) {
        return deployRemoteCall(CourseCreator.class, web3j, transactionManager, gasPrice, gasLimit, BINARY, "");
    }

    protected String getStaticDeployedAddress(String networkId) {
        return _addresses.get(networkId);
    }

    public static String getPreviouslyDeployedAddress(String networkId) {
        return _addresses.get(networkId);
    }
}
