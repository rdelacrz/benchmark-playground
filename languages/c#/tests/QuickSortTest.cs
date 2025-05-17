using System;
using NUnit.Framework;
using static Operations.QuickSortOperation;

namespace NUnit.Tests
{
    [TestFixture]
    public class QuickSortTest
    {
        [TestCaseSource(nameof(StringListsForQuickSort))]
        public void QuickSortTest_StringLists(string[] unsorted, string[] expectedResult, string message)
        {
            string[] actualResult = (string[])QuickSort(unsorted);
            Assert.That(actualResult, Is.EqualTo(expectedResult), message);
        }

        [Test]
        public void QuickSortTest_IntegerLists()
        {
            IComparable[] unsorted = [4, -54, 40, 400, 2, -7, 0, 1, 4];
            IComparable[] expectedResult = [-54, -7, 0, 1, 2, 4, 4, 40, 400];

            IComparable[] actualResult = QuickSort(unsorted);
            Assert.That(actualResult, Is.EqualTo(expectedResult), "QuickSort: Integer Lists Test");
        }

        private static readonly object[] StringListsForQuickSort =
        [
            // Zero elements
            new object[] {
                Array.Empty<string>(),
                Array.Empty<string>(),
                "QuickSort: Zero Elements Test"
            },

            // One elements
            new object[] {
                new string[] { "badger" },
                new string[] { "badger" },
                "QuickSort: One Element Test"
            },

            // Multiple odd elements
            new object[] {
                new string[] { "zinc", "trap", "tree", "trait", "badger", "apple", "chemistry", "pig", "zoo" },
                new string[] { "apple", "badger", "chemistry", "pig", "trait", "trap", "tree", "zinc", "zoo" },
                "QuickSort: Multiple Odd Elements Test"
            },

            // Multiple odd elements
            new object[] {
                new string[] { "trap", "apple", "chemistry", "pig", "zoo", "tree", "trait", "badger", "zinc", "crack" },
                new string[] { "apple", "badger", "chemistry", "crack", "pig", "trait", "trap", "tree", "zinc", "zoo" },
                "QuickSort: Multiple Even Elements Test"
            }
        ];
    }
}