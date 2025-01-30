package cup.example;

public class ParserWithTree extends Parser {
    public ParserWithTree() { super(); }

    protected MultiTreeNode createDeclarationNode(MultiTreeNode declaration) {
        MultiTreeNode node = new MultiTreeNode("Declaration");
        node.addChild(declaration);
        return node;
    }

    protected MultiTreeNode createVarDeclarationNode(MultiTreeNode type, String name) {
        MultiTreeNode node = new MultiTreeNode("VarDeclaration", name);
        node.addChild(type);
        return node;
    }

    protected MultiTreeNode createFunDeclarationNode(MultiTreeNode type, String name, MultiTreeNode params, MultiTreeNode body) {
        MultiTreeNode node = new MultiTreeNode("FunDeclaration", name);
        node.addChild(type);
        if (params != null) node.addChild(params);
        if (body != null) node.addChild(body);
        return node;
    }
    
    protected MultiTreeNode createEmptyParamsList() {
	    return new MultiTreeNode("CallParamsList");
	}
	
	protected MultiTreeNode createTypeSpecifier(String typeName) { 
  		MultiTreeNode newNode = new MultiTreeNode("TypeSpecifier", typeName);	
  		return newNode;
  	}
	
	protected MultiTreeNode createOperatorSpecifier(String typeOperator) { 
  		MultiTreeNode newNode = new MultiTreeNode("TypeSpecifier", typeOperator);	
  		return newNode;
  	}

	protected MultiTreeNode createListNode(String listName, MultiTreeNode firstChild) {
		MultiTreeNode newNode = new MultiTreeNode(listName);
		newNode.addChild(firstChild);
		return newNode;
	}

    protected MultiTreeNode createFormalParNode(MultiTreeNode type, String name) {
        MultiTreeNode node = new MultiTreeNode("FormalParameter", name);
        node.addChild(type);
        return node;
    }

    protected MultiTreeNode createBlockNode(MultiTreeNode declarations, MultiTreeNode statements) {
        MultiTreeNode node = new MultiTreeNode("Block");
        if (declarations != null) node.addChild(declarations);
        if (statements != null) node.addChild(statements);
        return node;
    }

    protected MultiTreeNode createAssignmentNode(String variable, MultiTreeNode value) {
	    MultiTreeNode assignmentNode = new MultiTreeNode("Assignment", variable);
	    assignmentNode.addChild(value);  
	    return assignmentNode;
	}

    protected MultiTreeNode createExpressionNode(MultiTreeNode left, String operator, MultiTreeNode right) {
        MultiTreeNode node = new MultiTreeNode("Expression", operator);
        node.addChild(left);
        node.addChild(right);
        return node;
    }

    protected MultiTreeNode createUnaryExpressionNode(String operator, MultiTreeNode operand) {
        MultiTreeNode node = new MultiTreeNode("UnaryExpression", operator);
        node.addChild(operand);
        return node;
    }

    protected MultiTreeNode createIfNode(MultiTreeNode condition, MultiTreeNode ifBody, MultiTreeNode elseBody) {
        MultiTreeNode node = new MultiTreeNode("IfStatement");
        node.addChild(condition);
        node.addChild(ifBody);
        if (elseBody != null) node.addChild(elseBody);
        return node;
    }

    protected MultiTreeNode createWhileNode(MultiTreeNode condition, MultiTreeNode body) {
        MultiTreeNode node = new MultiTreeNode("WhileLoop");
        node.addChild(condition);
        node.addChild(body);
        return node;
    }

    protected MultiTreeNode createReturnNode(MultiTreeNode expr) {
        MultiTreeNode node = new MultiTreeNode("ReturnStatement");
        if (expr != null) node.addChild(expr);
        return node;
    }

    protected MultiTreeNode createWriteNode(MultiTreeNode expr) {
        MultiTreeNode node = new MultiTreeNode("WriteStatement");
        node.addChild(expr);
        return node;
    }

    protected MultiTreeNode createReadNode(MultiTreeNode expr) {
        MultiTreeNode node = new MultiTreeNode("ReadStatement");
        node.addChild(expr);
        return node;
    }

    protected MultiTreeNode createFunctionCallNode(String name, MultiTreeNode params) {
        MultiTreeNode node = new MultiTreeNode("FunctionCall", name);
        if (params != null) node.addChild(params);
        return node;
    }

    protected MultiTreeNode createVariableNode(String name) {
        return new MultiTreeNode("Variable", name);
    }

    protected MultiTreeNode createConstantNode(String value) {
        return new MultiTreeNode("Constant", value);
    }
}
