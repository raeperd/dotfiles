# Personal Programming Preferences

This file contains personal programming preferences and coding style guidelines for Claude Code when working on development projects.

## Code Style Preferences

### Function Design
- **Avoid single-use helper functions**: Prefer inlining code rather than creating helper functions that are only used once
- **Simplicity over abstraction**: Choose simpler, more direct code over complex abstractions when the simpler approach meets requirements
- **Minimal code changes**: When fixing issues or implementing features, prefer the minimal code change that solves the problem

### Code Organization
- **Top-down declaration order**: Define functions, classes, variables, and structs in top-to-bottom reading order
- **Caller before callee**: If function A uses function B, declare function A first, then function B
- **Readable flow**: Code should read naturally from top to bottom, with high-level functions first and implementation details following

### Commit Strategy
- **Atomic commits**: Split work into small, focused commits that each serve a single purpose
- **TDD workflow**: Follow test-driven development with separate commits for:
  1. Add failing tests
  2. Check build/compilation 
  3. Implement code to make tests pass
  4. Refactor if needed

### Testing Philosophy
- **Integration tests over unit tests**: Prefer testing components in realistic environments rather than isolated unit tests
- **Real service testing**: For services like gRPC endpoints, run actual servers in tests and make real calls
- **Database integration**: Use real databases (with Docker containers) rather than mocks for database testing
- **Parallelizable tests**: Write tests that can run in parallel when possible for faster test execution
- **Go parallel tests**: Use `t.Parallel()` in Go tests to enable concurrent execution

## Example Testing Pattern

```go
// Preferred: Integration test with real gRPC server and database
func TestMain(m *testing.M) {
    // Set up real MySQL container with Docker
    mysqlContainer, err = unittestdocker.RunMySQL(ctx, "test-synonym")
    
    // Create real database connection
    testDB, err = sqlx.Connect("mysql", dsn)
    
    // Set up real gRPC server with bufconn
    testServer = NewSynonymHandler(testDB)
    lis = bufconn.Listen(1024 * 1024)
    grpcServer = grpc.NewServer()
    v1grpc.RegisterSynonymServiceServer(grpcServer, testServer)
    
    // Create real gRPC client
    grpcClient = v1grpc.NewSynonymServiceClient(clientConn)
    
    exitCode := m.Run()
    // Cleanup...
}

func TestSynonymServiceServer_ListSynonyms(t *testing.T) {
    // Test by making actual gRPC calls to running server
    listResp, err := grpcClient.ListSynonyms(ctx, &v1grpc.ListSynonymsRequest{})
    require.NoError(t, err)
    
    // Verify real database state and responses
    assert.Equal(t, int32(8), listResp.TotalItems)
}
```

## Key Testing Characteristics

### Setup Patterns
- Use `TestMain` for setting up real infrastructure (databases, servers)
- Use Docker containers for external dependencies (MySQL, Redis, etc.)
- Use `bufconn` for in-memory gRPC server testing
- Set up and tear down real data for each test scenario

### Test Structure
- **Arrange**: Set up real infrastructure and test data
- **Act**: Make actual service calls (gRPC, HTTP, database queries)
- **Assert**: Verify real responses and side effects
- **Cleanup**: Clean up test data and connections

### Data Management
- Use `setupTestData()` and `cleanupTestData()` helper functions for test data management
- Insert realistic test data that reflects production scenarios
- Test with various data states (empty, populated, edge cases)

## Development Workflow

1. **Write failing integration test** with real infrastructure
2. **Verify test fails** and commit test
3. **Implement minimal code** to make test pass
4. **Run tests** to verify implementation
5. **Commit implementation** separately from tests
6. **Refactor** if needed with separate commit

This approach ensures robust, realistic testing while maintaining clear development history through focused commits.